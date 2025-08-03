//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MoodNftIntegration is Test {
    MoodNft moodNft;
    DeployMoodNft deployer;

    string public constant SAD_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIj4KPHBhdGggZD0iTTEwIDVIMVYxMEg1VjV6IiBmaWxsPSJibGFjayIvPgo8L3N2Zz4=";
    string public constant HAPPY_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxMDAiIGhlaWdodD0iMTAwIj4KPHBhdGggZD0iTTEwIDVIMVYxMEg1VjV6IiBmaWxsPSJ5ZWxsb3ciLz4KPC9zdmc+Cg==";

    address USER = makeAddr("USER");

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function test_ViewTokenURIWithIntegration() public {
        vm.prank(USER);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }

    // function test_FlipMoodIntegration() public {
    //     vm.prank(USER);
    //     moodNft.mintNft();
    //     vm.prank(USER);
    //     moodNft.flipMood(0);
    //     assert(keccak256(abi.encodePacked(moodNft.tokenURI(0))) == keccak256(abi.encodePacked(SAD_SVG_URI)));
    // }
}
