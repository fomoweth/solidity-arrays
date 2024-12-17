## Solidity-Arrays

Implementation of JS built-in array functions in Solidity

- [reduce](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L9)
- [map](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L27)
- [filter](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L44)
- [forEach](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L73)
- [find](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L85)
- [indexOf](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L100)
- [includes](https://github.com/fomoweth/solidity-arrays/blob/7ed8890dc9f430e69ea9104bef635fb182e8c409/src/libraries/Arrays.sol#L114)

## Usage

Create `.env` file with the following content:

```text
# Using Infura
INFURA_API_KEY="YOUR_INFURA_API_KEY"
RPC_ETHEREUM="https://mainnet.infura.io/v3/${INFURA_API_KEY}"

# Using Alchemy
ALCHEMY_API_KEY="YOUR_ALCHEMY_API_KEY"
RPC_ETHEREUM="https://eth-mainnet.g.alchemy.com/v2/${ALCHEMY_API_KEY}"

# Optional
ETHERSCAN_API_KEY_ETHEREUM="YOUR_ETHERSCAN_API_KEY"
ETHERSCAN_URL_ETHEREUM="https://api.etherscan.io/api"

```

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```
