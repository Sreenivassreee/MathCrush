class Category {
  final int id;
  final String level;
  final String title;
  final String message;
  final String ex;
  Category({this.id, this.level, this.title, this.message, this.ex});
}

final List<Category> categories = [
  Category(
    id: 1,
    level: "1",
    title: "Numbers into Spellings 1 to 100",
    message:
        "In this 1st level u will work on conversions of numbers into spellings from 1 to 100",
    ex: "1 = One",
  ),
  Category(
    id: 2,
    level: "2",
    title: "Spellings into Numbers 1 to 100",
    message:
        "In this 2ed level u will work on conversions of Spellings into Numbers from 1 to 100",
    ex: "One = 1",
  ),
  Category(
    id: 3,
    level: "3",
    title: "Identify the Even Numbers 1-100",
    message:
        "In this 3ed level u will work on Identify the Even Numbers from 1 to 100",
    ex: "Find Even Number : 1,2,3,5 || Ans : 2",
  ),
  Category(
    id: 4,
    level: "4",
    title: "Identify the Even Numbers",
    message: "In this 4th level u will work on Identify the Even Numbers",
    ex: "Find Even Number : 101,102,103,105 || Ans : 102",
  ),
  Category(
    id: 5,
    level: "5",
    title: "Identify the Odd Numbers 1-100",
    message:
        "In this 5th level u will work on Identify the Odd Numbers from 1 to 100",
    ex: "Find Odd Number : 1,2,3,5 || Ans : 2",
  ),
  Category(
    id: 6,
    level: "6",
    title: "Identify the Odd Numbers",
    message: "In this 6th level u will work on Identify the Odd Numbers",
    ex: "Find Odd Number : 101,102,103,105 || Ans : 102",
  ),
  Category(
    id: 7,
    level: "7",
    title: "Roman Numbers 1 to 1000",
    message: "In this 7th level u will work on Roman Numbers from 1 to 1000",
    ex: "Roman Number : I   ||   Ans : 1",
  ),
  Category(
    id: 8,
    level: "8",
    title: "Ascending Order",
    message: "In this 8th level u will work on Ascending Order",
    ex: "Ascending order of : 2,3,1,6 || Ans : 1,2,3,6",
  ),
  Category(
    id: 9,
    level: "9",
    title: "Descending Order",
    message: "In this 9th level u will work on Descending Order",
    ex: "Descending Order of : 2,3,1,6 || Ans : 6,3,2,1",
  ),
  Category(
    id: 10,
    level: "10",
    title: "Additions ( E ) with 2",
    message:
        "In this 10th level u will work on Additions in Easy level Problems with 2 numbers",
    ex: "1 + 1 || Ans : 2",
  ),
  Category(
    id: 11,
    level: "11",
    title: "Additions ( M ) with 2",
    message:
        "In this 11th level u will work on Additions in Medium level Problems with 2 numbers",
    ex: "7 + 1 || Ans : 8",
  ),
  Category(
    id: 12,
    level: "12",
    title: "Substactions ( E ) with 2",
    message:
        "In this 12th level u will work on Substactions in Easy level Problems with 2 numbers",
    ex: "1 - 1 || Ans : 0",
  ),
  Category(
    id: 13,
    level: "13",
    title: "Substactions ( M ) with 2",
    message:
        "In this 13th level u will work on Substactions in Medium level Problems with 2 numbers",
    ex: "6 - 2 || Ans : 4",
  ),
  Category(
    id: 14,
    level: "14",
    title: "multiplication ( E ) with 2",
    message:
        "In this level u will work on multiplication in Easy level Problems with 2 numbers",
    ex: "1 x 1 || Ans : 1",
  ),
  Category(
    id: 15,
    level: "15",
    title: "multiplication ( M ) with 2",
    message:
        "In this level u will work on multiplication in Medium level Problems with 2 numbers",
    ex: "3 x 9 || Ans : 27",
  ),
  Category(
    id: 16,
    level: "16",
    title: "Division ( E ) with 2",
    message:
        "In this level u will work on Division in Easy level Problems with 2 numbers",
    ex: "1 / 1 || Ans : 1",
  ),
  Category(
    id: 17,
    level: "17",
    title: "Division ( M ) with 2",
    message:
        "In this level u will work on Division in Medium level Problems with 2 numbers",
    ex: "9 / 3 || Ans : 3",
  ),
  Category(
    id: 18,
    level: "18",
    title: "Additions ( E ) with 3",
    message:
        "In this level u will work on Additions in Easy level Problems with 3 numbers",
    ex: "1 + 1 + 1 || Ans : 3",
  ),
  Category(
    id: 19,
    level: "19",
    title: "Additions ( M ) with 3",
    message:
        "In this level u will work on Additions in Medium level Problems with 3 numbers",
    ex: "9 + 6 + 4 || Ans : 19",
  ),
  Category(
    id: 20,
    level: "20",
    title: "Substactions ( E ) with 3",
    message:
        "In this level u will work on Substactions in Easy level Problems with 3 numbers",
    ex: "1 - 1 - 1 || Ans : -1",
  ),
  Category(
    id: 21,
    level: "21",
    title: "Substactions ( M ) with 3",
    message:
        "In this level u will work on Substactions in Medium level Problems with 3 numbers",
    ex: "7 - 2 - 1 || Ans : 4",
  ),
  Category(
    id: 22,
    level: "22",
    title: "multiplication ( E ) with 3",
    message:
        "In this level u will work on multiplication in Easy level Problems with 3 numbers",
    ex: "1 x 1 x 1 || Ans : 1",
  ),
  Category(
    id: 23,
    level: "23",
    title: "multiplication ( M ) with 3",
    message:
        "In this level u will work on multiplication in Medium level Problems with 3 numbers",
    ex: "9 x 2 x 4 || Ans : 72",
  ),
  Category(
    id: 24,
    level: "24",
    title: "Additions ( E ) with 4",
    message:
        "In this level u will work on Additions in Easy level Problems with 4 numbers",
    ex: "1 + 1 + 1 + 1 || Ans : 4 ",
  ),
  Category(
    id: 25,
    level: "25",
    title: "Additions ( M ) with 4",
    message:
        "In this level u will work on Additions in Medium level Problems with 4 numbers",
    ex: "6 + 2 + 8 + 1 || Ans : 17 ",
  ),
  Category(
    id: 26,
    level: "26",
    title: "Substactions ( E ) with 4",
    message:
        "In this level u will work on Substactions in Easy level Problems with 4 numbers",
    ex: "1 - 1 - 1 - 1 || Ans : - 2 ",
  ),
  Category(
    id: 27,
    level: "27",
    title: "Substactions ( M ) with 4",
    message:
        "In this level u will work on Substactions in Medium level Problems with 4 numbers",
    ex: "9 - 5 - 8 - 1 || Ans : - 5 ",
  ),
  Category(
    id: 28,
    level: "28",
    title: "multiplication ( E ) with 4",
    message:
        "In this level u will work on multiplication Easy level Problems with 4 numbers",
    ex: "1 x 1 x 1 x 1 || Ans : 1",
  ),
  Category(
    id: 29,
    level: "29",
    title: "multiplication ( M ) with 4",
    message:
        "In this level u will work on multiplication Medium level Problems with 4 numbers",
    ex: "5 x 1 x 2 x 7 || Ans : 70",
  ),
  Category(
    id: 30,
    level: "30",
    title: "Additions ( E ) with 5",
    message:
        "In this level u will work on multiplication Easy level Problems with 5 numbers",
    ex: "1 + 1 + 1 + 1 + 1 || Ans : 5",
  ),
  Category(
    id: 31,
    level: "31",
    title: "Additions ( M ) with 5",
    message:
        "In this level u will work on multiplication Medium level Problems with 5 numbers",
    ex: "5 + 1 + 2 + 7 + 2 || Ans : 17",
  ),
  Category(
    id: 32,
    level: "32",
    title: "Substactions ( E ) with 5",
    message:
        "In this level u will work on Substactions in Easy level Problems with 5 numbers",
    ex: "1 - 1 - 1 - 1 - 1 || Ans : - 3 ",
  ),
  Category(
    id: 33,
    level: "33",
    title: "Substactions ( M ) with 5",
    message:
        "In this level u will work on Substactions in Medium level Problems with 5 numbers",
    ex: "5 - 8 - 4 - 6 - 9 || Ans : - 22 ",
  ),
  Category(
    id: 34,
    level: "34",
    title: "multiplication ( E ) with 5",
    message:
        "In this level u will work on multiplication in Easy level Problems with 5 numbers",
    ex: "1 x 1 x 1 x 1 x 1 || Ans : - 3 ",
  ),
  Category(
    id: 35,
    level: "35",
    title: "multiplication ( M ) with 5",
    message:
        "In this level u will work on multiplication Medium level Problems with 5 numbers",
    ex: "5 x 1 x 2 x 7 x 1 || Ans : 70",
  ),
  Category(
    id: 36,
    level: "36",
    title: "Mixed Addition and Subtraction with 3",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Easy Level Questions with 3 numbers",
    ex: "1 + 1 - 1 || Ans : 1",
  ),
  Category(
    id: 37,
    level: "37",
    title: "Mixed Addition and Subtraction with 3",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Medium Level Questions with 3 numbers",
    ex: "9 + 3 - 1 || Ans : 4",
  ),
  Category(
    id: 38,
    level: "38",
    title: "Mixed Addition and Subtraction with 4",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Easy Level Questions with 4 numbers",
    ex: "1 + 1 - 1 - 1 || Ans : 0 ",
  ),
  Category(
    id: 39,
    level: "39",
    title: "Mixed Addition and Subtraction with 4",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Medium Level Questions with 4 numbers",
    ex: "9 + 3 - 1 - 2 || Ans : 9 ",
  ),
  Category(
    id: 40,
    level: "40",
    title: "Mixed Addition and Subtraction with 5",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Easy Level Questions with 5 numbers",
    ex: "1 + 1 - 1 - 1 - 1 || Ans : - 1 ",
  ),
  Category(
    id: 41,
    level: "41",
    title: "Mixed Addition and Subtraction with 5",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Medium Level Questions with 5 numbers",
    ex: "9 + 3 - 1 - 2 - 1 || Ans : 8 ",
  ),
  Category(
    id: 42,
    level: "42",
    title: "Mixed Addition and Subtraction with 6",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Easy Level Questions with 6 numbers",
    ex: "1 + 1 - 1 - 1 - 1 + 1 || Ans : 0 ",
  ),
  Category(
    id: 43,
    level: "43",
    title: "Mixed Addition and Subtraction with 6",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Medium Level Questions with 6 numbers",
    ex: "9 + 3 - 1 - 2 - 1 + 5 || Ans : 13 ",
  ),
  Category(
    id: 44,
    level: "44",
    title: "Mixed Addition and Subtraction with 7",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Easy Level Questions with 7 numbers",
    ex: "1 + 1 - 1 - 1 - 1 + 1 - 1 || Ans : - 1",
  ),
  Category(
    id: 45,
    level: "45",
    title: "Mixed Addition and Subtraction with 7",
    message:
        "In this level u will work on Mixed problems with Addition and Subtraction,Medium Level Questions with 7 numbers",
    ex: "1 + 3 - 5 - 9 - 1 + 5 || Ans : - 6 ",
  ),
  Category(
    id: 46,
    level: "46",
    title: "Mixed Multilication and Division with 3",
    message:
        "In this level u will work on Mixed problems with Multilication and Division,Easy Level Questions with 3 numbers",
    ex: "1 x 1 / 1 || Ans : 1",
  ),
  Category(
    id: 47,
    level: "47",
    title: "Mixed Multilication and Division with 3",
    message:
        "In this level u will work on Mixed problems with Multilication and Division,Medium Level Questions with 3 numbers",
    ex: "9 x 5 / 2 || Ans : 22.5",
  ),
  Category(
    id: 48,
    level: "48",
    title: "Mixed Multilication and Division with 4",
    message:
        "In this level u will work on Mixed problems with Multilication and Division,Easy Level Questions with 4 numbers",
    ex: "1 x 1 / 1 x 1 || Ans : 1",
  ),
  Category(
    id: 49,
    level: "49",
    title: "Mixed Multilication and Division with 4",
    message:
        "In this level u will work on Mixed problems with Multilication and Division,Medium Level Questions with 4 numbers",
    ex: "9 x 5 / 2 x 5 || Ans : 112.5",
  ),
  Category(
    id: 50,
    level: "50",
    title: "Mixed All Math Operations [E]",
    message:
        "In this level u will work on Mixed problems with All Math Operations,Easy Level Questions",
    ex: "1 x 1 - 1 x 2 || Ans : - 1",
  ),
  Category(
    id: 51,
    level: "51",
    title: "Mixed All Math Operations [E]",
    message:
        "In this level u will work on Mixed problems with All Math Operations,Easy Level Questions",
    ex: "1 x 1 - 1 x 2 || Ans : - 1",
  ),
  Category(
    id: 52,
    level: "52",
    title: "Mixed All Math Operations [M]",
    message:
        "In this level u will work on Mixed problems with All Math Operations,Medium Level Questions",
    ex: "6 x 2 - 2 x 5 || Ans : 2",
  ),
  Category(
    id: 53,
    level: "53",
    title: "Mixed All Math Operations [M]",
    message:
        "In this level u will work on Mixed problems with All Math Operations,Medium Level Questions",
    ex: "6 x 2 - 2 x 5 || Ans : 2",
  ),
  Category(
    id: 54,
    level: "54",
    title: "Mixed All Math Operations [H]",
    message:
        "In this level u will work on Mixed problems with All Math Operations,High Level Questions",
    ex: "6 x 2 - 2 x 5 || Ans : 2",
  ),
  Category(
    id: 55,
    level: "55",
    title: "Mixed All Math Operations [H]",
    message:
        "In this level u will work on Mixed All Math Operations,High Level Questions",
    ex: "6 x 2 - 2 x 5 || Ans : 2",
  ),
  Category(
    id: 56,
    level: "56",
    title: "Sentence Problems with Addition [E]",
    message:
        "In this level u will work on Sentence Problems with Addition,Easy Level Questions ",
    ex: "If X = 1 and Y = 2  Then X + Y  || Ans : 3",
  ),
  Category(
    id: 57,
    level: "57",
    title: "Sentence Problems with Addition [M]",
    message:
        "In this level u will work on Sentence Problems with Addition,Medium Level Questions ",
    ex: "If X = 1 and Y = 2  Then X + Y  || Ans : 3",
  ),
  Category(
    id: 58,
    level: "58",
    title: "Sentence Problems with Subtraction [E]",
    message:
        "In this level u will work on Sentence Problems with Subtraction,Easy Level Questions",
    ex: "If X = 1 and Y = 2  Then X - Y  || Ans : - 1",
  ),
  Category(
    id: 59,
    level: "59",
    title: "Sentence Problems with Subtraction [M]",
    message:
        "In this level u will work on Sentence Problems with Subtraction,Medium Level Questions",
    ex: "If X = 1 and Y = 2  Then X - Y  || Ans : - 1",
  ),
  Category(
    id: 60,
    level: "",
    title: "Sentence Problems with Multilication [E]",
    message:
        "In this level u will work on Sentence Problems with Multilication,Easy Level Questions",
    ex: "If X = 1 and Y = 2  Then X x Y  || Ans : 2",
  ),
  Category(
    id: 61,
    level: "61",
    title: "Sentence Problems with Multilication [M]",
    message:
        "In this level u will work on Sentence Problems with Multilication,Medium Level Questions",
    ex: "If X = 8 and Y = 2  Then X x Y  || Ans : 16",
  ),
  Category(
    id: 62,
    level: "62",
    title: "Sentence Problems with Division [E]",
    message:
        "In this level we will work on Sentence Problems with Division,Easy Level Questions",
    ex: "If X = 1 and Y = 2  Then X / Y  || Ans : 0.5",
  ),
  Category(
    id: 63,
    level: "63",
    title: "Sentence Problems with Division [M]",
    message:
        "In this level we will work on Sentence Problems with Division,Medium Level Questions",
    ex: "If X = 7 and Y = 2  Then X / Y  || Ans : 3.5",
  ),
  Category(
    id: 64,
    level: "64",
    title: "Input Math or Sign",
    message:
        "In this level we will work on Input Math or Sign based on the Logic of a Question",
    ex: "2 + 3 = ? || Ans : 5",
  ),
  Category(
    id: 65,
    level: "65",
    title: "Input Math or Sign",
    message:
        "In this level we will work on Input Math or Sign based on the Logic of a Question",
    ex: "2 + 3 = ? || Ans : 5",
  ),
  Category(
    id: 66,
    level: "66",
    title: "Input Math or Sign",
    message:
        "In this level we will work on Input Math or Sign based on the Logic of a Question",
    ex: "2 + 3 = ? || Ans : 5",
  ),
  Category(
    id: 67,
    level: "67",
    title: "Input Math or Sign",
    message:
        "In this level we will work on Input Math or Sign based on the Logic of a Question",
    ex: "2 + 3 = ? || Ans : 5",
  ),
  Category(
    id: 68,
    level: "68",
    title: "Input Math or Sign",
    message:
        "In this level we will work on Input Math or Sign based on the Logic of a Question",
    ex: "2 + 3 = ? || Ans : 5",
  ),
];
