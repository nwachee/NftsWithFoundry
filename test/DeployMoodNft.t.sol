//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";

contract DeployMoodNftTest is Test{
    DeployMoodNft deployMoodNft;

    function setUp() public {
        deployMoodNft = new DeployMoodNft();
    }
}