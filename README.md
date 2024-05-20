# LayerZero-Sybil-Report-Manager
This repository contains a smart contract aimed at reducing spam activities on layerzero sybil hunt.

The smart contract requires that Sybil hunters send 0.1 ether along with their reports which serves as a "stake". If the report is discovered to be spam by the admins
then the user loses their ether. However, if the report is considered to be a non-spam report, then the admin can call the approve function which returns the user's ether.

The contract assigns a sequential ID to each report created, the ID can later be used to identify each report as well as the creator of the report. this allows the contract to accurately send funds back to the creators of non-spam reports.

