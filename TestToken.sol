pragma solidity >=0.7.0 <0.9.0;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


    event Transfer(address indexed from, address indexed to, uint256 value);
}


contract TestToken is IERC20 {

    string public constant name = "TestToken";
    string public constant symbol = "TestToken";
    uint8 public constant decimals = 0;
    address Owner_;

    mapping(address => bool) isContri;
    mapping(uint256 => address) contributors;
    mapping(address => uint256) balances;

    uint256 totalSupply_;

    using SafeMath for uint256;


   constructor(uint256 total) public {
        Owner_ = msg.sender;
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }

    function addContributor(address _addr) private {
        require(Owner_ == msg.sender);
        isContri[_addr] = true;
    }

    function deleteContributor(address _addr) private {
        require(Owner_ == msg.sender);
        isContri[_addr] = false;
    }

    function isContributor(address _addr) public view returns (bool) {
        return isContri[_addr];
    }

    function balanceOf(address tokenOwner) public override view returns (uint256) {
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public override returns (bool) {
        require(numTokens <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender, receiver, numTokens);
        return true;
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        return false;
    }

    function allowance(address owner, address spender) public override view returns (uint256) {
        return 0;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        return false;
    }
}

library SafeMath {
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}
