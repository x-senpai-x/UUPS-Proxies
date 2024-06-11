//SPDX-LICENSE-IDENTIFIER:MIT
//This is the contract we will be upgrading
//we will be using UUPS Proxy
pragma solidity ^0.8.20;
import {UUPSUpgradeable} from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts/access/OwnableUpgradeable.sol";
//Note : Proxies don't use constructor since it adds to storage to the implemention so indexing of variables is mismatched
//storage is stored in proxy and not the implementation contract
//contract marked as abstract because parent class(UUPSUpgradeable) doens't have all the functions implemented 
contract BoxV1 is UUPSUpgradeable ,Initializable,OwnableUpgradeable{
  //note we can't inherit in the wrong order 
  uint256 internal number;
  /// @custom:oz-upgrades-unsafe-allow constructor
  //allows the use of constructor in proxy
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

  //not using the constructor at all is equivalent to what has been done above
  //this just ensures we do not use constructor at any time in the contract
  function getNumber() external view returns(uint256){
    return number;
  }
  function version() external returns(uint256){
    return 1;
  }
  //this function is required if we want only certain set of addresses to upgrade the contract
  //here anyone can upgrade it since fn is left blank
  function _authorizeUpgrade(address newImplementation) internal override {
  
  }
}