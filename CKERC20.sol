pragma solidity ^0.6.0

contract cryptonkiddtoken{
  
  string public tokenName = "CryptonKidd";
  string public tokenSymbol = "CNK";
  unit256 public totalSupply = 500000000;
  unit8 public decimals = 18;
  
  event Transfer(
    address indexed_from;
    address indexed_to;
    uint256 _value;
  );
  
  event Approval(
    address indexed_owner;
    address indexed_spender;
    uint256 _value;
  );
  
  mapping(address => uint256) public balances;
  mapping(address => uint256(address => uint256)) public allowed;
  
  constructor() public{
    balances[msg.sender] = totalSupply;
  }
  
  function totalsupply() public view return(uint256){
        return totalSupply;
  }
  
  function balanceOf(address _owner) public view returns(unint256){
    return balances[_owner];
  }
  
  function transfer(address _to, uint256 _value) public returns(bool success){
    require(balances[msg.sender] >= _value);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
    returns true; 
  }
  
  function approve(address _spender, uint256 _value) public returns(bool success){
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    returns true;
  }
  
  function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    balances[_from] -= _value;
    balances[_to] += _value;
    allowed[_from][msg.sender] -= _value;
    emit transfer(_from, _to, _value);
    returns true;
  }

}
