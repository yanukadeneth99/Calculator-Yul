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

      //* add(uint256,uint256)
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