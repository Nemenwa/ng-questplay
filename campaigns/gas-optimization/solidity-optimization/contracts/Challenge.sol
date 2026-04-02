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
