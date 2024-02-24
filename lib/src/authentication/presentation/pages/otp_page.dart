// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:house_rental/core/size/sizes.dart';
import 'package:house_rental/core/spacing/whitspacing.dart';
import 'package:house_rental/core/widgets/show_toast.dart';
import 'package:house_rental/locator.dart';
import 'package:house_rental/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:house_rental/src/authentication/presentation/pages/signup_page.dart';
import 'package:house_rental/src/home/presentation/pages/home_page.dart';
//import 'package:house_rental_admin/src/home/presentation/pages/home_page.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:telephony/telephony.dart';
import 'package:oktoast/oktoast.dart';

class OTPRequest {
  String? verifyId, phoneNumber, id, uid, oldNumberString;
  int? forceResendingToken;
  bool isLogin;
  //void Function()? onSuccessCallback;

  OTPRequest({
    this.verifyId,
    this.uid,
    this.id,
    this.phoneNumber,
    this.forceResendingToken,
    required this.isLogin,
    this.oldNumberString,
    //  this.onSuccessCallback,
  });
}

class OTPPage extends StatefulWidget {
  final OTPRequest otpRequest;
  const OTPPage({
    Key? key,
    required this.otpRequest,
  }) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  Telephony telephony = Telephony.instance;

  final authBloc = locator<AuthenticationBloc>();
  String _otpString = "";
  OtpFieldController otpBox = OtpFieldController();
  String? verificationId;
  bool isLoading = false;
  bool isResend = true;
  String? sms;
  bool resend = false;
  String? see;

  // timerCheck() {
  //   Future.delayed(const Duration(seconds: 90), () {
  //     setState(() {
  //       resend = true;
  //     });
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  void getRemoveFocus(String value, FocusNode focus) {
    if (value.length == 1) {
      focus.requestFocus();
    }
  }

  @override
  void initState() {
    super.initState();
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        // print(message.address); //+977981******67, sender nubmer
        // print(message.body); //Your OTP code is 34567
        // print(message.date); //1659690242000, timestamp

        String sms = message.body.toString(); //get the message

        if (message.address == "Google" ||
            message.address == "CloudOTP" ||
            message.address == "InfoSMS") {
          //verify SMS is sent for OTP with sender number
          String otpcode = sms.replaceAll(RegExp(r'[^0-9]'), '');
          //prase code from the OTP sms
          // print("This is $otpcode");
          otpBox.set(otpcode.split(""));
          //split otp code to list of number
          //and populate to otb boxes
          setState(() {});
        } else {
          // print("Normal message.");
        }
      },
      // onBackgroundMessage:(SmsMessage message) {
      //   String sms = message.body.toString();
      //   if(message.address == "Google" || message.address=="CloudOTP" ||
      //       message.address=="wasime" || message.address=="Wasime"){
      //     String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'),'');
      //     otpbox.set(otpcode.split(""));
      //   }} ,
      listenInBackground: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer(
          listener: (conteext, state) async {
            if (state is VerifyOTPFailed) {
              debugPrint(state.errorMessage);
              showToastInfo(
              context:  context,
               label: state.errorMessage,
               isFailed:true,
                     );
             
            }
            if (state is VerifyOTPLoaded) {
              debugPrint("calling call back function");
              //widget.otpRequest.onSuccessCallback?.call();
              //print(state.user);
              if (widget.otpRequest.isLogin) {
               Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage(
                      isLogin: widget.otpRequest.isLogin,
                      phoneNumber: widget.otpRequest.phoneNumber,
                      uid: state.user.uid,
                    );
                  }),
                );
              } else if (widget.otpRequest.oldNumberString != null) {
                context.pushNamed("changeNumber",
                queryParameters: {
                  "phoneNumber":state.user.phoneNumber 
                });
              } else {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignupPage(
                      phoneNumber: state.user.phoneNumber ?? "",
                      uid: state.user.uid,
                    );
                  }),
                );
                
                //context.goNamed("signin");
              }
            }
          },
          bloc: authBloc,
          builder: (context, state) {
            if (state is VerifyOTPLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: EdgeInsets.all(Sizes().height(context, 0.006)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "We've sent a code to the number ${widget.otpRequest.phoneNumber}",
                    ),
                    Space().height(context, 0.04),
                    OTPTextField(
                      length: 6,
                      onChanged: onKeyPressed,
                      keyboardType: TextInputType.number,
                      controller: otpBox,
                      otpFieldStyle: OtpFieldStyle(
                          borderColor: Colors.black,
                          enabledBorderColor: Colors.black),
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 50,
                      fieldStyle: FieldStyle.box,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      //fieldStyle: F,
                      onCompleted: (val) async {
                        // print(val);
                        Future.delayed(const Duration(seconds: 2), () {
                          PhoneAuthCredential params =
                              PhoneAuthProvider.credential(
                                  verificationId:
                                      widget.otpRequest.verifyId.toString(),
                                  smsCode: _otpString);
                          authBloc.add(VerifyOTPEvent(params: params));
                          
                        });
                      },
                    ),
                    Space().height(context, 0.04),
                    timer(),
                    Space().height(context, 0.04),
                    Row(
                      children: [
                        Visibility(
                          visible: !isResend,
                          child: const Text("Didn't receive OTP?",
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                        ),
                        TextButton(
                            onPressed: () {
                              authBloc.add(PhoneNumberEvent(
                                  phoneNumber: widget.otpRequest.phoneNumber!));
                            },
                            child: Visibility(
                              visible: !isResend,
                              child: const Text("Resend",
                                  style: TextStyle(
                                    fontSize: 15,
                                  )),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Row timer() {
    return Row(
      children: [
        Visibility(
          visible: isResend,
          replacement: const Text(
            "Code expired",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
          child: TweenAnimationBuilder(
            onEnd: () {
              isResend = false;
              setState(() {});
            },
            tween: Tween(begin: 90.0, end: 0),
            duration: const Duration(seconds: 120),
            builder: (BuildContext context, value, Widget? child) => Text(
              "This code will expire in 00:${(value).toInt()}",
              style: const TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        )
      ],
    );
  }

  void onKeyPressed(String inputValue) {
    setState(() {
      _otpString = inputValue;
    });
  }


}
