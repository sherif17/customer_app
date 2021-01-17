import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common_widgets/background.dart';
import 'form_error.dart';
import 'components/or_divider.dart';
import 'register_form.dart';
import 'components/social_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

    return Background(
      child: SingleChildScrollView(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        child: Column(
          children: <Widget>[
            // SizedBox(height: size.height * 0.00005),
            Text(
              "What's Your Name",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RegisterForm()),
            SizedBox(height: size.height * 0.02),
            OrDivider(),
            SizedBox(height: size.height * 0.02),
            SocialRoundedButton(
              text: 'Continue with Facebook',
              iconSrc: 'assets/icons/facebook.svg',
              press: () {},
            ),
            SizedBox(height: size.height * 0.02),
            SocialRoundedButton(
              text: 'Continue with Google',
              iconSrc: 'assets/icons/gmail_logo.svg',
              press: ()  async {
                //body: ChangeNotifierProvider(
                //  create: (context) => GoogleSignInProvider(),
                //child: StreamBuilder(
                //  stream: FirebaseAuth.instance.authStateChanges(),
                //)
                //);
                //final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                //provider.login();
                try{
                    await _googleSignIn.signIn();
                  var name = Text(_googleSignIn.currentUser.displayName);
                  var image = Image.network(_googleSignIn.currentUser.photoUrl);
                  print(name);
                }
                catch(err){
                  print(err);
                }
                },
            ),
            SizedBox(height: size.height * 0.02),
            SocialRoundedButton(
              text: 'Continue with Apple ID',
              iconSrc: 'assets/icons/apple.svg',
              press: (){
              },
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
