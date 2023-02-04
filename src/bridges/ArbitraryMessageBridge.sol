// SPDX-License-Identifier: MIT
pragma solidity >=0.6.9 <0.9.0;

interface ArbitraryMessageBridge {
    function maxGasPerTx() external view returns (uint256);
    function requireToPassMessage(address target, bytes calldata data, uint256 gas) external returns (bytes32);
}
