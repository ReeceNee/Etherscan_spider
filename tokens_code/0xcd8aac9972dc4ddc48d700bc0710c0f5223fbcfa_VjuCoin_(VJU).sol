//token_name	0xcd8aac9972dc4ddc48d700bc0710c0f5223fbcfa_VjuCoin_(VJU)
//token_url	https://etherscan.io/address/0xcd8aac9972dc4ddc48d700bc0710c0f5223fbcfa#code
//spider_time	2018/07/02 10:41:37
//token_Transactions	306 txns
//token_price	

pragma solidity ^0.4.13;

contract ERC20Interface {
  function totalSupply() constant returns (uint256 supply);
  function balanceOf(address _owner) constant returns (uint256 balance);
  function transfer(address _to, uint256 _value) returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
  function approve(address _spender, uint256 _value) returns (bool success);
  function allowance(address _owner, address _spender) constant returns (uint256 remaining);
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract VjuCoin is ERC20Interface {
  string public constant symbol = "VJU";
  string public constant name = "VjuCoin";
  uint8 public constant decimals = 0;
  uint256 _totalSupply = 100000000;
  address public owner;
  mapping(address => uint256) balances;
  mapping(address => mapping (address => uint256)) allowed;
  modifier onlyOwner() {
    if (msg.sender != owner) {revert();}
    _;
  }
  
  function VjuCoin() {
    owner = msg.sender;
    balances[owner] = _totalSupply;
  }
   
  function totalSupply() constant returns (uint256 supply) {
    supply = _totalSupply;
  }
   
  function balanceOf(address _owner) constant returns (uint256 balance) {
    return balances[_owner];
  }
   
  function transfer(address _to, uint256 _amount) returns (bool success) {
    if (balances[msg.sender] >= _amount && _amount > 0 && balances[_to] + _amount > balances[_to]) {
      balances[msg.sender] -= _amount;
      balances[_to] += _amount;
      Transfer(msg.sender, _to, _amount);
      return true;
    } else {return false;}
  }
   
  function transferFrom(address _from,address _to,uint256 _amount) returns (bool success) {
    if (balances[_from] >= _amount && allowed[_from][msg.sender] >= _amount && _amount > 0 && balances[_to] + _amount > balances[_to]) {
      balances[_from] -= _amount;
       allowed[_from][msg.sender] -= _amount;
       balances[_to] += _amount;
       Transfer(_from, _to, _amount);
       return true;
    } else {return false;}
  }
  
  function approve(address _spender, uint256 _amount) returns (bool success) {
    allowed[msg.sender][_spender] = _amount;
    Approval(msg.sender, _spender, _amount);
    return true;
  }
  
  function allowance(address _owner, address _spender) constant returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

  function () {
    revert();
  }
   
}