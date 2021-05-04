// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "./libraries/WadRayMath.sol";
import "./libraries/Errors.sol";
import "./libraries/DataStruct.sol";
import "./interfaces/IMoneyPool.sol";
import "./interfaces/ITokenizer.sol";

/**
 * @title ELYFI Tokenizer
 * @author ELYSIA
 */
contract Tokenizer is ITokenizer, ERC1155Upgradeable {
    using WadRayMath for uint256;

    IMoneyPool internal _moneyPool;

    mapping(uint256 => address) internal _minter;

    uint256 internal _totalATokenSupply;

    function initialize(
        IMoneyPool moneyPool,
        string memory uri_
    ) public initializer {
        _moneyPool = moneyPool;
        __ERC1155_init(uri_);
    }

    function getMinter(
        uint256 id
    ) external view returns (address) {
        return _minter[id];
    }

    // id : bitMask
    function mintABToken(
        address account, // CO address
        uint256 id // information about CO and borrower
    ) external override onlyMoneyPool {

        if (_minter[id] != address(0)) revert(); ////error ABTokenIDAlreadyExist(id)

        // mint ABToken to CO
        _mint(account, id, 1, "");

        _minter[id] = account;
    }

    function mintAToken(
        address account,
        uint256 id,
        uint256 amount,
        uint256 realAssetAPR
    ) external override onlyMoneyPool {
        _totalATokenSupply += amount;
    }

    function totalATokenSupply() external view override returns (uint256) {
        return _totalATokenSupply;
    }

    modifier onlyMoneyPool {
        if (_msgSender() != address(_moneyPool)) revert(); ////OnlyMoneyPool();
        _;
    }
}