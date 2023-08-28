//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import {Reputations} from "../src/Reputations.sol";
import {BaseTest} from "./base/BaseTest.t.sol";

contract ReputationsTest is BaseTest {
    Reputations public reputations;
    // the appId from the Sismo Connect App we want to use
    bool isImpersonationMode = false; // <--- set to true to allow verifying proofs from impersonated accounts
    // sismo dataGroupIds
    bytes16 public constant TEAM_MEMBERS_GROUP_ID = 0xf44c3e70f9147f1a4d59077451535f00;
    bytes16 public constant G2M_GROUP_ID = 0x7cccd0183c6ca02e76600996a671a824;
    // bytes16 public constant DATA_GROUP_ID = 0x6d6ab4793a05fbdafbb8895f8e9eef14; // ten eths group

    // sismo appId
    bytes16 public constant APP_ID = 0x1267ea070ec44221e85667a731eee045;
    uint256 public constant DURATION = 7 days;

    address public account = 0xb5AB443DfF53F0e397a9E0778A3343Cbaf4D001a;

    function setUp() public {
        Reputations.GroupSetup[] memory groups = new Reputations.GroupSetup[](2);
        groups[0] = (Reputations.GroupSetup({groupId: TEAM_MEMBERS_GROUP_ID, startAt: 1000, duration: 1 days}));
        groups[1] = (Reputations.GroupSetup({groupId: G2M_GROUP_ID, startAt: 12000, duration: 1 days}));

        reputations = new Reputations(
          APP_ID,
          DURATION,
          isImpersonationMode,
          groups
      );
    }

//    function test_bindReputation() public {
//        bytes memory response = hex"00000000000000000000000000000000000000000000000000000000000000201267ea070ec44221e85667a731eee04500000000000000000000000000000000b8e2054f8a912367e38a22ce773328ff000000000000000000000000000000007369736d6f2d636f6e6e6563742d76312e31000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000b5ab443dff53f0e397a9e0778a3343cbaf4d001a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000001a068796472612d73332e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001c000000000000000000000000000000000000000000000000000000000000004a0000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011ced80673868b95a4e1e17b846881eedfd35ab926b3a90f6390a8af8027678e600000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0192871958c496294a65975ddc105f7b7b2a4057281f5fda821c7c645b8d0cd7a2db655bef1ac3f28923db3bca5ba0fae1892228905953d55ed14574816719293114ec57d2d0c104693cb8baf52f46aeb7fec43c6f4fea443008d6807c8d0d5992d3119e25ca662477516401b3c1dd8f47ff49ec4b4a2e9f1e1a9b0f4ae0c2eaa0ef79bcc51ab61fec1b7a137b629803a60b64cacb3d38722e5320e65effd3cce0e3289b2b6507d8eb3e0605edd67c9e11a9f3ff7cd3eef895d57071c3ea8eee822f09532054b34060facb475a6ac855597c8c4facc9731207d366a7b0948009d06a5fb869529952a2f963408baabf0948a2fa91b3efca1084829e1f15350c549000000000000000000000000000000000000000000000000000000000000000002b8a512b4aaebb2955485bc52ef1c2957ab167b3784a33ff5dff93ce2cc8e8b07f6c5612eb579788478789deccb06cf0eb168e457eea490af754922939ebdb920706798455f90ed993f8dac8075fc1538738a25f0c928da905c0dffd81869fa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001ced80673868b95a4e1e17b846881eedfd35ab926b3a90f6390a8af8027678e617deb519a568cd1e54da8d268b86077d4e3d1cbe735d60461ac36a99654bca9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73332e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000f44c3e70f9147f1a4d59077451535f00000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c01f0d5b130875c6c616db2aebae524b71cc96142b6c4abfafbf25424062b4074421757eb2a2be3a22247722a529cd004baae64e793440077479037a40214445021b073f80c8daff226f254e0e35bf5e5f0d953fb2d09b8d0a2834abc89b73729c11d67e6a7abcc225d1989ec6de3979b8552f76683eab4f16e7beaa7fc7375f9b125ae5bd6a3c727eb6eb3ec44e602bef08f36510c47ecab23dff2a680f72706e24b3041705dfb6f4de6f5223532d7aed506a50380be4289e1807d202158a5dcd013c488fc8206a516ea2ca1f0d2e54fc1580093d0d021d4760a81726c822565e28504c70e9cd0dbb8eac686f0b15f2476ab2090c4362e99eea56e65336fd1f99000000000000000000000000000000000000000000000000000000000000000002b8a512b4aaebb2955485bc52ef1c2957ab167b3784a33ff5dff93ce2cc8e8b07f6c5612eb579788478789deccb06cf0eb168e457eea490af754922939ebdb920706798455f90ed993f8dac8075fc1538738a25f0c928da905c0dffd81869fa19e663c4c9fa7f90eeefd8d91162240682d496533dd3f7306445cf133230c1d92b4d048d74ba4392342fcd8decf07742556ec7fae4eb17ff51e181f94fcfb48d143bf633750b17355486194a660c7cf29c7c05130a47fa78fde5cd2897e236f900000000000000000000000000000000000000000000000000000000000000010256b632931c5e49b3c7aae3c9cca52ea35deafb12d4cd29ac96341c4ffffffb00000000000000000000000000000000000000000000000000000000000000001ced80673868b95a4e1e17b846881eedfd35ab926b3a90f6390a8af8027678e617deb519a568cd1e54da8d268b86077d4e3d1cbe735d60461ac36a99654bca90000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
//        vm.startPrank(account);
//        reputations.bindReputation(account, response);
//
//        Reputations.Reputation[] memory reps = reputations.reputationDetail(account);
//        uint256 len = reps.length;
//        for(uint i = 0; i< len ; i++){
//            console.log("reputation::groupId ");
//            console.logBytes16(reps[i].groupId);
//            console.log("reputation::value ", reps[i].value);
//            console.log("reputation::expiredAt ", reps[i].expiredAt);
//        }
//
//        uint256 expiredAt = block.timestamp + 1 days - ((block.timestamp - 1000 ) % 1 days);
//        assertEq(reps[0].groupId, TEAM_MEMBERS_GROUP_ID);
//        assertEq(reps[0].value, true);
//        assertEq(reps[0].expiredAt, expiredAt);
//
//        assertEq(reps[1].groupId, bytes16(0));
//        assertEq(reps[1].value, false);
//        assertEq(reps[1].expiredAt, 0);
//    }

    function test_reputationDetail() public {
        bytes memory response = hex"00000000000000000000000000000000000000000000000000000000000000201267ea070ec44221e85667a731eee04500000000000000000000000000000000b8e2054f8a912367e38a22ce773328ff000000000000000000000000000000007369736d6f2d636f6e6e6563742d76312e31000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000b5ab443dff53f0e397a9e0778a3343cbaf4d001a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000001a068796472612d73332e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001c000000000000000000000000000000000000000000000000000000000000004a0000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011ced80673868b95a4e1e17b846881eedfd35ab926b3a90f6390a8af8027678e600000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c0192871958c496294a65975ddc105f7b7b2a4057281f5fda821c7c645b8d0cd7a2db655bef1ac3f28923db3bca5ba0fae1892228905953d55ed14574816719293114ec57d2d0c104693cb8baf52f46aeb7fec43c6f4fea443008d6807c8d0d5992d3119e25ca662477516401b3c1dd8f47ff49ec4b4a2e9f1e1a9b0f4ae0c2eaa0ef79bcc51ab61fec1b7a137b629803a60b64cacb3d38722e5320e65effd3cce0e3289b2b6507d8eb3e0605edd67c9e11a9f3ff7cd3eef895d57071c3ea8eee822f09532054b34060facb475a6ac855597c8c4facc9731207d366a7b0948009d06a5fb869529952a2f963408baabf0948a2fa91b3efca1084829e1f15350c549000000000000000000000000000000000000000000000000000000000000000002b8a512b4aaebb2955485bc52ef1c2957ab167b3784a33ff5dff93ce2cc8e8b07f6c5612eb579788478789deccb06cf0eb168e457eea490af754922939ebdb920706798455f90ed993f8dac8075fc1538738a25f0c928da905c0dffd81869fa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001ced80673868b95a4e1e17b846881eedfd35ab926b3a90f6390a8af8027678e617deb519a568cd1e54da8d268b86077d4e3d1cbe735d60461ac36a99654bca9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000c068796472612d73332e310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e000000000000000000000000000000000000000000000000000000000000004c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000f44c3e70f9147f1a4d59077451535f00000000000000000000000000000000006c617465737400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002c01f0d5b130875c6c616db2aebae524b71cc96142b6c4abfafbf25424062b4074421757eb2a2be3a22247722a529cd004baae64e793440077479037a40214445021b073f80c8daff226f254e0e35bf5e5f0d953fb2d09b8d0a2834abc89b73729c11d67e6a7abcc225d1989ec6de3979b8552f76683eab4f16e7beaa7fc7375f9b125ae5bd6a3c727eb6eb3ec44e602bef08f36510c47ecab23dff2a680f72706e24b3041705dfb6f4de6f5223532d7aed506a50380be4289e1807d202158a5dcd013c488fc8206a516ea2ca1f0d2e54fc1580093d0d021d4760a81726c822565e28504c70e9cd0dbb8eac686f0b15f2476ab2090c4362e99eea56e65336fd1f99000000000000000000000000000000000000000000000000000000000000000002b8a512b4aaebb2955485bc52ef1c2957ab167b3784a33ff5dff93ce2cc8e8b07f6c5612eb579788478789deccb06cf0eb168e457eea490af754922939ebdb920706798455f90ed993f8dac8075fc1538738a25f0c928da905c0dffd81869fa19e663c4c9fa7f90eeefd8d91162240682d496533dd3f7306445cf133230c1d92b4d048d74ba4392342fcd8decf07742556ec7fae4eb17ff51e181f94fcfb48d143bf633750b17355486194a660c7cf29c7c05130a47fa78fde5cd2897e236f900000000000000000000000000000000000000000000000000000000000000010256b632931c5e49b3c7aae3c9cca52ea35deafb12d4cd29ac96341c4ffffffb00000000000000000000000000000000000000000000000000000000000000001ced80673868b95a4e1e17b846881eedfd35ab926b3a90f6390a8af8027678e617deb519a568cd1e54da8d268b86077d4e3d1cbe735d60461ac36a99654bca90000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        vm.startPrank(account);
        reputations.bindReputation(account, response);
        uint256 expiredAt = block.timestamp + 1 days - ((block.timestamp - 1000 ) % 1 days);

        console.log("block timestamp: ", block.timestamp);
        vm.warp(block.timestamp + 100 days);
        console.log("after block timestamp: ", block.timestamp);

        Reputations.Reputation[] memory reps = reputations.reputationDetail(account);
        uint256 len = reps.length;
        for(uint i = 0; i< len ; i++){
            console.log("reputation::groupId ");
            console.logBytes16(reps[i].groupId);
            console.log("reputation::value ", reps[i].value);
            console.log("reputation::expiredAt ", reps[i].expiredAt);
        }

        assertEq(reps[0].groupId, TEAM_MEMBERS_GROUP_ID);
        assertEq(reps[0].value, false);
        assertEq(reps[0].expiredAt, expiredAt);

        assertEq(reps[1].groupId, bytes16(0));
        assertEq(reps[1].value, false);
        assertEq(reps[1].expiredAt, 0);
    }
}
