//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
       
    }

    function svgToImageURI(string memory svg) public pure returns (string memory){
    string memory svgBase64Encoded = Base64.encode(bytes(svg));
    string memory baseURL = "data:image/svg+xml;base64,";
    return string(string.concat(baseURL, svgBase64Encoded));
    }
}