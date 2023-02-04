// SPDX-License-Identifier: MIT
pragma solidity >=0.6.9 <0.9.0;

interface OptimismBridge {
    function sendMessage(address target, bytes calldata message, uint32 gasLimit) external;
}
