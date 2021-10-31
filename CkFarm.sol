pragma solidity ^0.6.0;

import "./CKERC20.sol";
// address 0x0099b5B75926D42BeB3Cf271b32D21282d57C938

contract CkFarm{
  string public name = "CryptonKidd Token Farm";
  CKERC20 public ckToken;
  DaiToken public daiToken;
  address public owner;
  
  mapping(address => uint) public stakeBalance;
  mapping(address => uint) public hasStaked;
  mapping(address => uint) public isStaking;
  address[] public stakers;
  
  constructor(DaiToken _DaiToken, CKERC20 _CryptonToken) public{
    ckToken = _CryptonToken;
    daiToken = _DaiToken;
    owner = msg.sender;
  }
  
  function stakeToken(uint _amount) public {
        require(_amount > 0, "amount stake cannot be zero");
        daiToken.transferFrom(msg.sender, address(this), _amount);
        stakeBalance[msg.sender] = stakeBalance[msg.sender] + _amount;

        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }
        hasStaked[msg.sender] = true;
    }
    
    function unstakeToken() public{
        require(isStaking[msg.sender] == true, "You have nothing to Unstake");
        uint balance = stakeBalance[msg.sender];
        daiToken.transfer(msg.sender, balance);
        isStaking[msg.sender] = false;
    }
    
    function stakeAmount(address _owner) public view returns(uint){
        returns stakeBalance[_owner];
    }
    
    function issueToken() public{
        require(msg.sender == onwer, "Owner cannot be determined");
        for(uint i=0; i<stakers.length; i++){
            address recipient = stakers[i];
            if(isStaking[recipient] == true){
                uint balance = stakeBalance[recipient];
                ckToken.transfer(recipient, balance);
            }
        }
    }
}
