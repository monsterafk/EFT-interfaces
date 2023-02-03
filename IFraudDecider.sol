// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IFraudDecider {
    //
    function decide(
        uint256 tokenId,
        string calldata cid,
        bytes calldata publicKey,   //decide if there was a fact of fraud
        bytes calldata privateKey,
        bytes calldata encryptedPassword
    ) external returns(bool, bool);
}