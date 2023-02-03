// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IEncryptedFileTokenCallbackReceiver  {
    function transferCancelled(uint256 tokenId) external; //This function must be called if transfer is cancelled
    function transferFinished(uint256 tokenId) external; //This function must be called if transfer is finished successfully
    function transferFrauDetected(uint256 tokenId, bool approves) external; //This function must be called if transfer is finished with fraud report
} 