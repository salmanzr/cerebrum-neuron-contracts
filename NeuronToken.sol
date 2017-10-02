pragma solidity ^0.4.2;


/// @title Abstract token contract - Functions to be implemented by token contracts.
contract Token 
  {
  function transfer(address to, uint256 value) returns (bool);
  function transferFrom(address from, address to, uint256 value) returns (bool);
  function approve(address spender, uint256 value) returns (bool);
  
  function totalSupply() constant returns (uint256) {}
  function balanceOf(address who) constant returns (uint256);
  function allowance(address owner, address spender) constant returns (uint256);
    
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
  }


/// @title Standard token contract - Standard token interface implementation.
contract StandardToken is Token 
  {
  /* Data structures */
  mapping(address => uint256) balances;
  mapping (address => mapping (address => uint256)) allowed;
  uint256 public totalSupply;
  
  /* Public functions */
    
  /// @dev Transfers sender's tokens to a given address. Returns success.
  /// @param _to Address of token receiver.
  /// @param _value Number of tokens to transfer.
  /// @return Returns success of function call.	
  function transfer(address _to, uint256 _value) public returns (bool) 
    {
    if (balances[msg.sender] < _value) { throw;	}
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    Transfer(msg.sender, _to, _value);
    return true;
    }
    
  /// @dev Allows allowed third party to transfer tokens from one address to another. Returns success.
  /// @param _from Address from where tokens are withdrawn.
  /// @param _to Address to where tokens are sent.
  /// @param _value Number of tokens to transfer.
  /// @return Returns success of function call.
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool)
    {
    if (balances[_from] < _value || allowed[_from][msg.sender] < _value) { throw; }
    balances[_from] -= _value;
    balances[_to] += _value;
    allowed[_from][msg.sender] -= _value;
    Transfer(_from, _to, _value);
    return true;
    }
    
  /// @dev Approve the passed address to spend the specified amount of tokens on behalf of msg.sender. Returns success.
  /// @param _spender Address of the account with the allowed spending.
  /// @param _value Number of approved tokens for spending.
  /// @return Returns success of function call.
  function approve(address _spender, uint256 _value) public returns (bool)
    {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
    }
    
  /* Read functions */  
    
  /// @dev Checks and returns the amount of tokens that an owner allowed to a spender.
  /// @param _owner Address of token owner.
  /// @param _spender Address of token spender.
  /// @return Returns remaining allowance for spender.
  function allowance(address _owner, address _spender) constant public returns (uint256)
    {
    return allowed[_owner][_spender];
    }
   
  /// @dev Returns number of tokens owned by given address.
  /// @param _owner Address of token owner.
  /// @return Returns balance of owner.
  function balanceOf(address _owner) constant public returns (uint256)
    {
    return balances[_owner];
    }
  }


/// @title Neuron Token contract
contract NeuronToken is StandardToken
  {
  /* Token Meta Data */
  string constant public name = "Neuron";
  string constant public symbol = "NRN";
  uint8 constant public decimals = 18;
  
  /* Public functions */
  /* Initializes contract with initial supply tokens to the creator of the contract */
  function NeuronToken() public
    {
    uint256 initialSupply = 50000000 * 10**18;
    totalSupply = initialSupply;
    balances[msg.sender] = initialSupply;
    }
  }
