// SPDX-License-Identifier: MIT
pragma solidity >=0.6.9 <0.9.0;

import "./bridges/ArbitrumBridge.sol";
import "./bridges/OptimismBridge.sol";
import "./bridges/PolygonBridge.sol";
import "./bridges/ArbitraryMessageBridge.sol";

/// @title Unified interface for sending messages from Ethereum to other chains and rollups
/// @author zefram.eth
/// @notice Enables sending messages from Ethereum to other chains via a single interface.
/// @dev This bridge is immutable, so other contracts using it should have the ability to
/// update the bridge address in order to upgrade to newer versions of the bridge in the future
/// and support more chains.
interface IUniversalBridge {
    function CHAINID_ARBITRUM() external pure returns (uint256);
    function BRIDGE_ARBITRUM() external pure returns (ArbitrumBridge);
    function CHAINID_OPTIMISM() external pure returns (uint256);
    function BRIDGE_OPTIMISM() external pure returns (OptimismBridge);
    function CHAINID_POLYGON() external pure returns (uint256);
    function BRIDGE_POLYGON() external pure returns (PolygonBridge);
    function CHAINID_BSC() external pure returns (uint256);
    function BRIDGE_BSC() external pure returns (ArbitraryMessageBridge);
    function CHAINID_GNOSIS() external pure returns (uint256);
    function BRIDGE_GNOSIS() external pure returns (ArbitraryMessageBridge);

    /// @notice Sends message to recipient on target chain with the given calldata.
    /// @dev For calls to Arbitrum, any extra msg.value above what getRequiredMessageValue() returns will
    /// be used as the msg.value of the L2 call to the recipient.
    /// @param chainId the target chain's ID
    /// @param recipient the message recipient on the target chain
    /// @param data the calldata the recipient will be called with
    /// @param gasLimit the gas limit of the call to the recipient
    function sendMessage(uint256 chainId, address recipient, bytes calldata data, uint256 gasLimit) external payable;

    /// @notice Sends message to recipient on target chain with the given calldata.
    /// @dev For calls to Arbitrum, any extra msg.value above what getRequiredMessageValue() returns will
    /// be used as the msg.value of the L2 call to the recipient.
    /// @param chainId the target chain's ID
    /// @param recipient the message recipient on the target chain
    /// @param data the calldata the recipient will be called with
    /// @param gasLimit the gas limit of the call to the recipient
    /// @param maxFeePerGas the max gas price used, only relevant for some chains (e.g. Arbitrum)
    function sendMessage(
        uint256 chainId,
        address recipient,
        bytes calldata data,
        uint256 gasLimit,
        uint256 maxFeePerGas
    ) external payable;

    /// @notice Computes the minimum msg.value needed when calling sendMessage()
    /// @param chainId the target chain's ID
    /// @param dataLength the length of the calldata the recipient will be called with, in bytes
    /// @param gasLimit the gas limit of the call to the recipient
    /// @return the minimum msg.value required
    function getRequiredMessageValue(uint256 chainId, uint256 dataLength, uint256 gasLimit)
        external
        view
        returns (uint256);

    /// @notice Computes the minimum msg.value needed when calling sendMessage()
    /// @param chainId the target chain's ID
    /// @param dataLength the length of the calldata the recipient will be called with, in bytes
    /// @param gasLimit the gas limit of the call to the recipient
    /// @param maxFeePerGas the max gas price used, only relevant for some chains (e.g. Arbitrum)
    /// @return the minimum msg.value required
    function getRequiredMessageValue(uint256 chainId, uint256 dataLength, uint256 gasLimit, uint256 maxFeePerGas)
        external
        view
        returns (uint256);
}
