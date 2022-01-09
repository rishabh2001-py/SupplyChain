//Implement EIP20 TOKEN FROM GITHUB
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;
import "./erc20Interface.sol";


contract ERC20Token is ERC20Interface{

    uint256 constant private MAX_UINT256 = 2**256-1;
    mapping(address => uint256)public balances;
    mapping(address => mapping(address=>uint)) public allowed; 

    string public name;                     //Descriptive name 
    string public symbol;                  //Short identifier for token
    // uint256 override public totSupply;
    uint8 public decimals;                // Decimal to add after point


    // Create the new token ans assign initial values , including initial amount

    constructor(

        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol

    ) public {
        balances[msg.sender] = _initialAmount;
        totSupply = _initialAmount;
        name = _tokenName ;
        symbol = _tokenSymbol;
    } 
    // Transfer tokens from msg.sender to a specified address

    function transfer(address _to, uint256 _value) override public returns (bool success){

        require(balances[msg.sender] >= _value,"Insufficient funds");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to,_value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) override public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value,"Insufficient allowed funds for transfer source.");
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        emit Transfer(_from, _to, _value);
        return true;
    }

    // Return the current balance (in tokens) of a specified address
    function balanceOf(address _owner) override public view returns (uint256 balance) {
        return balances[_owner];
    }

    // Set
    function approve(address _spender, uint256 _value) override public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // Return the
    function allowance(address _owner, address _spender) override public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    // Return the total number of tokens in circulation
    function totalSupply() override public view returns (uint256 totSupp) {
        return totSupply;
    }









} 