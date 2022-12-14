object "Calculator" {
  code {
    // Constructor
    datacopy(0, dataoffset("runtime"), datasize("runtime")) // Copy the data from 0 - Runtime object
    return(0, datasize("runtime")) // Return the Runtime Object to the miner
  }

  // Main Contract
  object "runtime" {
    code {
      // Run the function based on its selector value
      // Remember the case stops after running in Yul (Dont need break)
      switch getSelector()

      //* Function to Add two numbers
      // add(uint256,uint256)
      case 0x771602f7 {

        // Get First Number passed
        let val1 := calldataload(4)

        // Get the Second Number passed which is after 32 bytes + 4 bytes
        let val2 := calldataload(0x24)

        // Store the addition of sent numbers onto memory slot 0
        mstore(0, add(val1, val2))

        // Return 0 - 32bytes
        return(0, 0x20)
      }

      //* Function to Subtract two numbers
      // subtract(uint256,uint256)
      case 0x3ef5e445 {
        

        // If the first number is greater than the second number , Store the two numbers passed into the memory slot 0
        if gt(calldataload(4), calldataload(0x24)) {mstore(0, sub(calldataload(4), calldataload(0x24)))}

        // If the first number is less than the second number , Store the substraction in reverse order into the memory slot 0
        if lt(calldataload(4), calldataload(0x24)) {mstore(0, sub(calldataload(0x24),calldataload(4)))}

        return(0, 0x20)
      }

      //* Function to Multiply two numbers
      // multiply(uint256,uint256)
      case 0x165c4a16 {
        
        // Store the multiplication of sent numbers onto memory slot 0
        mstore(0, mul(calldataload(4), calldataload(0x24)))

        return(0, 0x20)
      }

      //* Function to Multiply two numbers
      // divide(uint256,uint256)
      case 0xf88e9fbf {
        
        // If the first number is greater than the second number , Store the two numbers passed into the memory slot 0
        if gt(calldataload(4), calldataload(0x24)) {mstore(0, div(calldataload(4), calldataload(0x24)))}

        // If the first number is less than the second number , Store the substraction in reverse order into the memory slot 0
        if lt(calldataload(4), calldataload(0x24)) {mstore(0, div(calldataload(0x24),calldataload(4)))}

        return(0, 0x20)
      }

      // If nothing is found just revert. No Fallback
      default {
        revert(0,0)
      }

      // Helper Functions
      function getSelector() -> selector {
        // Get the first 4 bytes
        selector := div(calldataload(0), 0x100000000000000000000000000000000000000000000000000000000)
      }
    }
  }
}