// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/// @title Arrays

library Arrays {
	int256 internal constant NOT_FOUND = -1;

	function reduce(
		bytes32[] memory array,
		function(bytes32, bytes32) view returns (bytes32) callback,
		bytes32 initialValue
	) internal view returns (bytes32 result) {
		unchecked {
			uint256 length = array.length;
			uint256 offset;

			result = initialValue;

			while (offset < length) {
				result = callback(result, array[offset]);
				++offset;
			}
		}
	}

	function map(
		bytes32[] memory array,
		function(bytes32) view returns (bytes32) callback
	) internal view returns (bytes32[] memory result) {
		unchecked {
			uint256 length = array.length;
			uint256 offset;

			result = new bytes32[](length);

			while (offset < length) {
				result[offset] = callback(array[offset]);
				++offset;
			}
		}
	}

	function filter(
		bytes32[] memory array,
		function(bytes32) view returns (bool) callback
	) internal view returns (bytes32[] memory result) {
		unchecked {
			uint256 length = array.length;
			uint256 offset;
			uint256 count;

			result = new bytes32[](length);

			while (offset < length) {
				bytes32 current = array[offset];
				if (callback(current)) {
					result[count] = current;
					++count;
				}

				++offset;
			}

			assembly ("memory-safe") {
				if xor(length, count) {
					mstore(result, count)
				}
			}
		}
	}

	function forEach(bytes32[] memory array, function(bytes32) view returns (bytes32) callback) internal view {
		unchecked {
			uint256 length = array.length;
			uint256 offset;

			while (offset < length) {
				array[offset] = callback(array[offset]);
				++offset;
			}
		}
	}

	function find(
		bytes32[] memory array,
		function(bytes32) view returns (bool) callback
	) internal view returns (bytes32 result) {
		unchecked {
			uint256 length = array.length;
			uint256 offset;

			while (offset < length) {
				if (callback(array[offset])) return array[offset];
				++offset;
			}
		}
	}

	function indexOf(bytes32[] memory array, bytes32 value) internal pure returns (int256 index) {
		unchecked {
			uint256 length = array.length;
			uint256 offset;

			while (offset < length) {
				if (array[offset] == value) break;
				++offset;
			}

			return offset != length ? int256(offset) : NOT_FOUND;
		}
	}

	function includes(bytes32[] memory array, bytes32 value) internal pure returns (bool) {
		return indexOf(array, value) != NOT_FOUND;
	}
}
