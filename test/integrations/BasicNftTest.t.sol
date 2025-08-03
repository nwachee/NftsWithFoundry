//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract BasicNftTest is Test, IERC721Receiver {
    DeployBasicNft public deployer;
    BasicNft basicNft;
    address public USER = makeAddr("user");
    address public APPROVED = makeAddr("approved");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    error ERC721InvalidReceiver(address receiver);

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    // Required so this contract can receive safeTransferFrom or safeMint
    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }

    function test_NameIsCorrect() public view {
        string memory expectedName = "RandomNFT";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function test_CanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);
        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }

    function test_ApprovedAddressCanTransfer() public {
        basicNft.mintNft(PUG);
        basicNft.approve(APPROVED, 0);
        vm.prank(APPROVED);
        basicNft.transferFrom(address(this), address(USER), 0);
        assertEq(basicNft.ownerOf(0), address(USER));
    }

    function test_TransferChangesOwnership() public {
        basicNft.mintNft(PUG);
        basicNft.transferFrom(address(this), USER, 0);
        assertEq(basicNft.ownerOf(0), USER);
    }

    function test_TokenUriIsCorrect() public {
        basicNft.mintNft(PUG);

        string memory uri = basicNft.tokenURI(0);
        assertEq(uri, PUG);
    }

    function test_TransferToZeroAddressReverts() public {
        basicNft.mintNft(PUG);
        vm.expectRevert(abi.encodeWithSelector(ERC721InvalidReceiver.selector, address(0)));
        basicNft.transferFrom(address(this), address(0), 0);
    }
}
