// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.13;

import {CREATE3Script} from "./base/CREATE3Script.sol";
import {UniversalBridge} from "../src/UniversalBridge.sol";

contract DeployScript is CREATE3Script {
    constructor() CREATE3Script(vm.envString("VERSION")) {}

    function run() external returns (UniversalBridge bridge) {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));

        vm.startBroadcast(deployerPrivateKey);

        bridge = UniversalBridge(
            create3.deploy(getCreate3ContractSalt("UniversalBridge"), type(UniversalBridge).creationCode)
        );

        vm.stopBroadcast();
    }
}
