// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Challenge {
    uint256 private immutable SKIP_VALUE;

    error Overflow();

    constructor(uint256 skip_) {
        SKIP_VALUE = skip_;
    }

 /**
     * @notice Sums all elements in the array except values equal to SKIP_VALUE
     * @param array The input array (calldata)
     * @return sum The resulting sum excluding skipped values
     */

 function sumAllExceptSkip(
        uint256[] calldata array
    ) external view returns (uint256 sum) {
        uint256 skip = SKIP_VALUE;

        assembly {
            let ptr := array.offset
            let end := add(ptr, shl(5, array.length)) // length * 32

            for { } lt(ptr, end) { ptr := add(ptr, 0x20) } {
                let value := calldataload(ptr)

                // Skip matching values
                if iszero(eq(value, skip)) {
                    let newSum := add(sum, value)

                    // Overflow check: if newSum < sum, overflow occurred
                    if lt(newSum, sum) {
                        // Store function selector for Overflow()
                        mstore(0x00, 0x35278d12)
                        revert(0x1c, 0x04)
                    }

                    sum := newSum
                }
            }
        }
    }
}
