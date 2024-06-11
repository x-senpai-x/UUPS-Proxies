//This is the upgraded contract
//SPDX-LICENSE-IDENTIFIER:MIT
//This is the contract we will be upgrading
//we will be using UUPS Proxy
pragma solidity ^0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "lib/openzeppelin-contracts-upgradeable/contracts/access/OwnableUpgradeable.sol";

contract BoxV2 is UUPSUpgradeable ,Initializable,OwnableUpgradeable{

  uint256 internal number;
  //we can't change storage variables in upgraded contract 
  constructor() {
        _disableInitializers();//disables any initialization to happen
        //usually we initialize here but in this contract we will initialize in the intialize fn
        
    }
  //we deploy our contract and then have the proxy immediately call the initialize fn
  function initialize() public initializer{
    __Ownable_init;//sets owner to msg.msg.sender
    //in normal contract we would have used owner=msg.sender in the constructor
    __UUPSUpgradeable_init();//initializes the proxy
  }
  
  function setNumber( uint256 _number) external {
    number = _number;
  } 
  function getNumber() external view returns(uint256){
    return number;
  }
  function version() external returns(uint256){
    return 2;
  }
}