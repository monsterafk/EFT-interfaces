// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './IEncryptedFileTokenCallbackReceiver .sol';
import 'lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol';


interface  IEncryptedFileToken is IERC721 {

    function initTransfer(
        uint256 tokenId,
        address to,
        bytes calldata data,
        IEncryptedFileTokenCallbackReceiver callbackReceiver
    ) external;

    function completeTransferDraft(
        uint256 tokenId,
        address to,
        bytes calldata publicKey,
        bytes calldata data
        ) external;

    function draftTransfer(uint256 tokenId, IEncryptedFileTokenCallbackReceiver callbackReceiver) external;
    function setTransferPublicKey(uint256 tokenId, bytes calldata data) external;
    function approvetransfer(uint256 tokenId, bytes calldata encryptedSecret) external;
    function finalizeTransfer(uint256 tokenId) external;
    function reportFraud(uint256 tokenId, bytes calldata data) external;
    function applyFraudDecision(uint256 tokenId, bool approved) external;
    function cancelTransfer(uint256 tokenId) external;
    function fraudDecisionInstant() external view returns (bool);
    function fraudDecider() external view returns (IFraudDecider);

    event TransferInit(uint256 indexed tokenId, address from, address to);
    event TransferDraft(uint256 indexed tokenId, address from);
    event TransferDraftCompletion(uint256 indexed tokenId, address to);
    event TransferPublicKeySet(uint256 indexed tokenId, bytes publicKey);
    event TransferPasswordSet(uint256 indexed tokenId, bytes encryptedSecret);
    event TransferFinished(uint256 indexed tokenId);
    event TransferFraudReported(uint256 indexed tokenId);
    event TransferFraudDecided(uint256 indexed tokenId, bool approved);
    event TransferCancellation(uint256 indexed tokenId);
}