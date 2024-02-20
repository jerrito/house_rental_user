import 'package:flutter/material.dart';

const houseGreyColor = Color.fromRGBO(215, 215, 215, 1);
const houseWhiteColor = Color.fromRGBO(255, 255, 255, 1);
const houseContainerRowColor = Color.fromRGBO(0, 0, 0, 0.24);
const housePrimaryColor = Color.fromRGBO(10, 142, 217, 1);
const houseBlack100 = Color.fromRGBO(0, 0, 0, 1);
const searchTextColor1 = Color.fromRGBO(133, 133, 133, 1);
const searchTextColor2 = Color.fromRGBO(131, 131, 131, 1);
const searchTextColor3 = Color.fromRGBO(212, 212, 212, 1);
const searchBackgroundColor = Color.fromRGBO(247, 247, 247, 1);
const blueOceanColor1 = Color.fromRGBO(160, 218, 251, 1);
const blueOceanColor2 = Color.fromRGBO(10, 142, 217, 1);

var primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomLeft,
    colors: [blueOceanColor1.withOpacity(0.9), blueOceanColor2]);
var houseContainerGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    const Color.fromRGBO(
      13,
      13,
      13,
      0.0,
    ).withOpacity(
      0.375,
    ),
    const Color.fromRGBO(
      0,
      0,
      0,
      0.80,
    ).withOpacity(
      0.6,
    )
  ],
);

var searchTextGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    searchTextColor2.withOpacity(
      0.375,
    ),
    searchTextColor2.withOpacity(
      0.6,
    )
  ],
);

//border-radius: 20px;
//background: linear-gradient(180deg, rgba(13, 13, 13, 0.00) 37.57%, rgba(0, 0, 0, 0.80) 100%);
