// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";

contract OurTokenTest is Test {
    OurToken ourToken;
    address bob = makeAddr("bob");
    address alice = makeAddr("alice");
    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() external {
        DeployOurToken deployer = new DeployOurToken();
        ourToken = deployer.run();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() external view {
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE);
    }

    function testAllowances() external {
        uint256 initialAllowance = 100;

        vm.prank(bob);
        ourToken.approve(alice, initialAllowance);

        uint256 transferAmount = 50;

        vm.prank(alice);
        ourToken.transferFrom(bob, alice, transferAmount);

        assertEq(ourToken.balanceOf(alice), transferAmount);
        assertEq(ourToken.balanceOf(bob), (STARTING_BALANCE - transferAmount));
    }
}
