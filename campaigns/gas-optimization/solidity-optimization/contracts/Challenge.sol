// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Challenge {
    uint256 private immutable SKIP_VALUE;

    error Overflow();

    constructor(uint256 skip_) {
        SKIP_VALUE = skip_;
    }
