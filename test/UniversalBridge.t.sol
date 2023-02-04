// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.4;

import "forge-std/Test.sol";

import "../src/UniversalBridge.sol";

contract UniversalBridgeTest is Test {
    UniversalBridge bridge;

    function setUp() public {
        bridge = new UniversalBridge();
    }

    function test_sendMessageArbitrum(address recipient, bytes calldata data) external {
        uint256 requiredValue = bridge.getRequiredMessageValue(bridge.CHAINID_ARBITRUM(), data.length, 1e6);
        bridge.sendMessage{value: requiredValue}(bridge.CHAINID_ARBITRUM(), recipient, data, 1e6);
    }

    function test_sendMessageOptimism(address recipient, bytes calldata data) external {
        bridge.sendMessage(bridge.CHAINID_OPTIMISM(), recipient, data, 1e6);
    }

    function test_sendMessagePolygon(address recipient, bytes calldata data) external {
        bridge.sendMessage(bridge.CHAINID_POLYGON(), recipient, data, 1e6);
    }

    function test_sendMessageBSC(address recipient, bytes calldata data) external {
        bridge.sendMessage(bridge.CHAINID_BSC(), recipient, data, 1e6);
    }

    function test_sendMessageGnosis(address recipient, bytes calldata data) external {
        bridge.sendMessage(bridge.CHAINID_GNOSIS(), recipient, data, 1e6);
    }
}
