// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

contract ManualToken {
    /*function name() public view returns (string memory) {
        return "OurToken";
    }*/
    mapping(address => uint256) s_addresses;
    string public name = "OurToken";

    function symbol() public pure returns (string memory) {
        return "OT";
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return s_addresses[_owner];
    }

    function transfer(address _to, uint256 amount) public {
        uint256 s_previousBalances = balanceOf(msg.sender) + balanceOf(_to);
        s_addresses[msg.sender] -= amount;
        s_addresses[_to] += amount;
        require((balanceOf(msg.sender) + balanceOf(_to)) == s_previousBalances);
    }
}
