// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console2 as console} from "forge-std/Test.sol";
import {Arrays} from "src/libraries/Arrays.sol";

contract ArraysTest is Test {
	using Arrays for bytes32[];

	address internal constant ETH = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;
	address internal constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
	address internal constant STETH = 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84;
	address internal constant WSTETH = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0;
	address internal constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

	bytes32[] assets;

	function setUp() public virtual {
		vm.createSelectFork(vm.envString("RPC_ETHEREUM"));

		assets.push(toBytes32(ETH));
		assets.push(toBytes32(WETH));
		assets.push(toBytes32(WSTETH));
		assets.push(toBytes32(STETH));

		deal(WETH, address(this), 100 ether);
		deal(WSTETH, address(this), 50 ether);
	}

	function test_reduce() public virtual {
		bytes32 expected = balanceOfSelf(assets[0]);
		bytes32 result = assets.reduce(reduceCallback, 0);

		assertEq(result, expected);
	}

	function test_map() public virtual {
		bytes32[] memory results = assets.map(balanceOfSelf);

		for (uint256 i; i < results.length; ++i) {
			assertEq(results[i], balanceOfSelf(assets[i]));
		}
	}

	function test_filter() public virtual {
		bytes32[] memory results = assets.filter(filterCallback);
		assertEq(results.length, assets.length - 1);

		for (uint256 i; i < results.length; ++i) {
			assertEq(results[i], assets[i]);
		}
	}

	function test_forEach() public virtual {
		bytes32[] memory results = assets;
		results.forEach(balanceOfSelf);

		for (uint256 i; i < results.length; ++i) {
			assertEq(results[i], balanceOfSelf(assets[i]));
		}
	}

	function test_find() public virtual {
		assertEq(assets.find(isETH), toBytes32(ETH));
		assertEq(assets.find(isWETH), toBytes32(WETH));
		assertEq(assets.find(isSTETH), toBytes32(STETH));
		assertEq(assets.find(isWSTETH), toBytes32(WSTETH));
	}

	function test_indexOf() public virtual {
		assertEq(assets.indexOf(toBytes32(ETH)), 0);
		assertEq(assets.indexOf(toBytes32(WETH)), 1);
		assertEq(assets.indexOf(toBytes32(WSTETH)), 2);
		assertEq(assets.indexOf(toBytes32(STETH)), 3);
		assertEq(assets.indexOf(toBytes32(USDC)), Arrays.NOT_FOUND);
	}

	function test_includes() public virtual {
		assertTrue(assets.includes(toBytes32(ETH)));
		assertTrue(assets.includes(toBytes32(WETH)));
		assertTrue(assets.includes(toBytes32(WSTETH)));
		assertTrue(assets.includes(toBytes32(STETH)));
		assertFalse(assets.includes(toBytes32(USDC)));
	}

	function reduceCallback(bytes32 acc, bytes32 asset) internal view returns (bytes32) {
		bytes32 value = balanceOfSelf(asset);
		return acc > value ? acc : value;
	}

	function filterCallback(bytes32 asset) internal view returns (bool flag) {
		return balanceOfSelf(asset) != 0;
	}

	function isETH(bytes32 asset) internal pure returns (bool flag) {
		assembly ("memory-safe") {
			flag := eq(asset, ETH)
		}
	}

	function isWETH(bytes32 asset) internal pure returns (bool flag) {
		assembly ("memory-safe") {
			flag := eq(asset, WETH)
		}
	}

	function isSTETH(bytes32 asset) internal pure returns (bool flag) {
		assembly ("memory-safe") {
			flag := eq(asset, STETH)
		}
	}

	function isWSTETH(bytes32 asset) internal pure returns (bool flag) {
		assembly ("memory-safe") {
			flag := eq(asset, WSTETH)
		}
	}

	function balanceOfSelf(bytes32 asset) internal view returns (bytes32 value) {
		assembly ("memory-safe") {
			switch eq(asset, ETH)
			case 0x00 {
				let ptr := mload(0x40)

				mstore(ptr, 0x70a0823100000000000000000000000000000000000000000000000000000000)
				mstore(add(ptr, 0x04), and(address(), 0xffffffffffffffffffffffffffffffffffffffff))

				value := mul(
					mload(0x00),
					and(gt(returndatasize(), 0x1f), staticcall(gas(), asset, ptr, 0x24, 0x00, 0x20))
				)
			}
			default {
				value := selfbalance()
			}
		}
	}

	function toBytes32(address input) internal pure returns (bytes32 output) {
		assembly ("memory-safe") {
			output := input
		}
	}
}
