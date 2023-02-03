// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import './IFraudDecider.sol';
import './IEncryptedFileTokenCallbackReceiver .sol';
import 'lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol';


interface  IEncryptedFileToken is IERC721 {

    //Init token transfer. Shortcut for draftTransfer+completeTransferDraft
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

    //lock NFT before receiver will be defined
    function draftTransfer(uint256 tokenId, IEncryptedFileTokenCallbackReceiver callbackReceiver) external;

    //set receiver public key
    function setTransferPublicKey(uint256 tokenId, bytes calldata data) external;

    //approve transfer and save encrypted password
    function approvetransfer(uint256 tokenId, bytes calldata encryptedSecret) external;

    //this function must call `transferFinished` callback function
    function finalizeTransfer(uint256 tokenId) external;

    //within this function fraud must be checked by IFraudDecider and if there is and instant decision, abandon transfer and call the callback
    function reportFraud(uint256 tokenId, bytes calldata data) external;

    //apply fraud decision, abandon transfer and call the callback
    //must revert if fraud decision making instant for this token instance
    //this function must call `transferFraudDetected` callback function
    function applyFraudDecision(uint256 tokenId, bool approved) external;

    //this function MUST call `transferCancelled` callback function
    function cancelTransfer(uint256 tokenId) external;

    //function to detect if fraud decision instant for this instance
    function fraudDecisionInstant() external view returns (bool);

    //function to get fraud decider instance for this token
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