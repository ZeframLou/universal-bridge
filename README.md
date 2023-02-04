# Universal bridge

Unified interface for sending messages from Ethereum to other chains and rollups.

It is essentially a quality-of-life wrapper around official bridges to make the developer experience simpler while maintaining the same security assumptions as the official bridges. This makes it much more secure than "omnichain" solutions like LayerZero, at least for rollups like Arbitrum and Optimism where the official bridge has the same security assumptions as the network itself. Of course, the Universal bridge only supports one-way messaging from Ethereum to other networks, so it is less capable than "omnichain" solutions, but it is still useful for use cases like cross-chain governance.

This bridge is immutable, so other contracts using it should have the ability to update the bridge address in order to upgrade to newer versions of the bridge in the future and support more chains.

The Universal bridge has been deployed to Ethereum Mainnet at [0xeb3113E09e1eDb7da11c1228F3A0c4919Ee0f6dE](https://etherscan.io/address/0xeb3113e09e1edb7da11c1228f3a0c4919ee0f6de#code).

## Supported chains

- Arbitrum
- Optimism
- Polygon
- Binance Smart Chain
- Gnosis Chain

## Usage

Sending a message is as easy as:

```solidity
uint256 requiredValue = bridge.getRequiredMessageValue(bridge.CHAINID_ARBITRUM(), data.length, gasLimit);
bridge.sendMessage{value: requiredValue}(bridge.CHAINID_ARBITRUM(), recipient, data, gasLimit);
```

Contracts on the receiving end of the message should have cross-chain support, which can be done by inheriting from the corresponding [OpenZeppelin Cross Chain Awareness](https://docs.openzeppelin.com/contracts/4.x/api/crosschain) specialization contract.

## Installation

To install with [Foundry](https://github.com/foundry-rs/foundry):

```
forge install zeframlou/universal-bridge
```

## Local development

This project uses [Foundry](https://github.com/foundry-rs/foundry) as the development framework.

### Dependencies

```
forge install
```

### Compilation

```
forge build
```

### Testing

```
forge test -f mainnet
```

### Contract deployment

Please create a `.env` file before deployment. An example can be found in `.env.example`.

#### Dryrun

```
forge script script/Deploy.s.sol -f [network]
```

### Live

```
forge script script/Deploy.s.sol -f [network] --verify --broadcast
```