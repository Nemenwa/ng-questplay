// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Challenge {
    uint256 immutable _SKIP;
    error Overflow();

    constructor(uint256 skip) {
        _SKIP = skip;
    }

    /**
     
@notice Returns the sum of the elements of the given array, skipping any SKIP value.
@param array The array to sum.
@return The sum of all the elements of the array excluding SKIP.*/
function sumAllExceptSkip(
    uint256[] calldata array) public view returns (uint256) {
    uint256 skip = _SKIP;
    uint256 sum;
    assembly {
        let offset := array.offset
        let end := add(offset, mul(array.length, 0x20))
        for { let i := offset } lt(i, end) { i := add(i, 0x20) } {
            let val := calldataload(i)
            // Only add if not equal to skip value
            if iszero(eq(val, skip)) {// Check for overflow before adding
                let newSum := add(sum, val)// Compare with original sum to detect overflow
                if lt(newSum, sum) {// Error signature for Overflow()
                    mstore(0x00, 0x35278d12)
                    revert(0x00, 0x04)}
                sum := newSum}}}
    return sum;}
}