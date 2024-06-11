//SPDX-LICENSE-IDENTIFIER:MIT

pragma solidity ^0.8.20;

import {Script} from "lib/forge-std/src/Script.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {ERC1967Proxy} from "@openzepp/contracts/proxy/ERC1967/ERC1967Proxy.sol";
contract DeployBox is Script {
    function run() external returns(address){
      address proxy=deployBox();
      return proxy;
    }
    function deployBox() public returns(BoxV1){
      BoxV1 box= new BoxV1();
      ERC1967Proxy proxy= new ERC1967Proxy(address(box),"");
      return address(proxy);

    }
}