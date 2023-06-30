// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 *@title NFTMarketplace
 *@dev A marketplace contract for trading ERC721 tokens.
*/

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTMarketplace is ERC721URIStorage {

  /**
    * @dev Structs
  */

  struct Token {
    uint256 tokenId;
    address payable seller;
    address payable owner;
    uint256 price;
    bool sold;
  }

  /**
    * @dev Storage Variables
  */

  uint256 public tokenIds;
  uint256 public itemsSold;
  uint256 public listingPrice;
  address payable owner;
  mapping(uint256 => Token) public idToToken;


  /**
    * @dev Events
  */

  event TokenCreated(
    uint256 indexed tokenId,
    address seller,
    address owner,
    uint256 price
  );

  event TokenSold(
    uint256 indexed tokenId,
    address seller,
    address owner,
    uint256 price
  );

  event ResaleCreated(
    uint256 indexed tokenId,
    address seller,
    address owner,
    uint256 price
  );


  /**
    * @dev Constructor
  */

  /**
  * @dev Initializes the NFT marketplace contract.
  */
  constructor() ERC721("NFTMarketPlace", "NFTM") {
    listingPrice = 0.1 ether;
    owner = payable(msg.sender);
  }


  /**
    * @dev Modifiers
  */

  /**
  * @dev Throws an error if the caller is not the marketplace owner.
  */
  modifier onlyOwner() {
    require(
      msg.sender == owner,
      "Caller is not the marketplace owner"
    );
    _;
  }


  /**
    * @dev Functions
  */

  /**
  * @dev Updates the listing price for creating tokens.
  * @param _listingPrice The new listing price.
  */
  function updateListingPrice(
    uint256 _listingPrice
  ) external onlyOwner {
    listingPrice = _listingPrice;
  }

  /**
  * @dev Gets the current listing price.
  * @return The current listing price.
  */
  function getListingPrice() external view returns (
    uint256
  ) {
    return listingPrice;
  }

}