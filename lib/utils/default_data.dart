import '../model/character_model.dart';

List<Character> charactersList() {
  List<Character> list = [];

  list.add(Character(
      img:
          "https://image.lexica.art/full_jpg/48ff1c4d-10e7-4090-a505-2cbba04ad5df",
      title: " Captain Jack Sparrow",
      desc:
          "Jack Sparrow was a legendary pirate of the Seven Seas, and the irreverent trickster of the Caribbean. A captain of equally dubious morality and sobriety, a master of self-promotion and self-interest, Jack fought a constant and losing battle with his own best tendencies while living a pirate's life. He was the quickest to seize the moment and make it his own. Whether by cause or accident was a matter of debate, but the results were the same and always different. Captain Jack's first love was the sea, his second, his beloved ship the Black Pearl.",
      token: "TM:da7yzmfnb8f8"));

  list.add(Character(
      img:
          "https://image.lexica.art/full_jpg/01baaf14-904f-4ec9-baf5-6d70dcd07ede",
      title: "Darth Vader",
      desc:
          "Once the heroic Jedi Knight named Anakin Skywalker, Darth Vader was seduced by the dark side of the Force. Forever scarred by his defeat on Mustafar, Vader was transformed into a cybernetically-enhanced Sith Lord. At the dawn of the Empire, Vader led the Empire’s eradication of the Jedi Order and the search for survivors. He remained in service of the Emperor -- the evil Darth Sidious -- for decades, enforcing his Master’s will and seeking to crush the Rebel Alliance and other detractors. But there was still good in him…",
      token: "TM:j764y97vfgbs"));

  list.add(
    Character(
        img:
            "https://image.lexica.art/full_jpg/9966e95c-0100-4aa3-b46d-359279bb0842",
        title: "Iron Man",
        desc:
            "Anthony Edward Tony Stark was a billionaire industrialist, a founding member of the Avengers, and the former CEO of Stark Industries. A brash but brilliant inventor, Stark was self-described as a genius, billionaire, playboy, and philanthropist. With his great wealth and exceptional technical knowledge, Stark was one of the world's most powerful men following the deaths of his parents and enjoyed the playboy lifestyle for many years until he was kidnapped by the Ten Rings in Afghanistan, while demonstrating a fleet of Jericho missiles. With his life on the line, Stark created an armored suit which he used to escape his captors. Upon returning home, he utilized several more armors to use against terrorists, as well as Obadiah Stane who turned against Stark. Following his fight against Stane, Stark publicly revealed himself as Iron Man.",
        token: "TM:cp6vg8m1n4qq"),
  );

  list.add(Character(
      img:
          "https://image.lexica.art/full_jpg/696fb01d-eb4b-4ac1-8a3f-a5eb03659163",
      title: "Batman",
      desc:
          "Batman is the superhero protector of Gotham City, a tortured, brooding vigilante dressed as a bat who fights against evil and strikes fear into the hearts of criminals everywhere. In his public identity, he is Bruce Wayne, a billionaire industrialist and notorious playboy. Although he has no superhuman abilities, he is one of the world's smartest men and greatest fighters. His physical prowess, technical ingenuity, and tactical thinking make him an incredibly dangerous opponent. He is also a founding member of the Justice League.",
      token: "TM:8tvy3m30zv62"));

  list.add(
    Character(
        img:
            "https://image.lexica.art/full_jpg/51253832-97c8-4ce0-9dc9-c8a3a184fa45",
        title: "Harley Quinn",
        desc:
            "Dr. Harleen Frances Quinzel, also known as Harley Quinn (a pun on the word harlequin), first appeared in the Batman: The Animated Series episode Joker's Favor, where she served as a humorous female sidekick to the Joker. In her first appearances she was depicted as a character completely devoted to the Joker, totally oblivious to his psychotic nature and obvious lack of affection for her; this characterization has remained more or less consistent throughout her subsequent appearances.",
        token: "TM:6kfh9y076ctn"),
  );

  // list.add(
  //   Character(
  //       img:
  //           "https://image.lexica.art/full_jpg/553d57c4-e6ae-49ca-8143-1675b601df8e",
  //       title: "Hermione Granger",
  //       link: "https://www.imdb.com/title/tt0241527/?ref_=nv_sr_srsg_0",
  //       desc:
  //           "Minister Hermione Jean[27] Granger (b. 19 September 1979)[1] was an English Muggle-born[3] witch born to Mr and Mrs Granger. At the age of eleven, she learned about her magical nature and was accepted into Hogwarts School of Witchcraft and Wizardry. Hermione began attending Hogwarts in 1991 and was Sorted into Gryffindor House. She possessed a brilliant academic mind and proved to be a gifted student in almost every subject that she studied, to the point where she was nearly made a Ravenclaw by the Sorting Hat.",
  //       token: ""),
  // );

  // list.add(Character(
  //     img:
  //         "https://image.lexica.art/full_jpg/1a963659-ed85-4a39-8dc4-71378ab562f0",
  //     title: "Rose",
  //     link: "https://www.imdb.com/title/tt0120338/?ref_=fn_al_tt_1",
  //     desc:
  //         "Rose was born in Philadelphia, Pennsylvania in 1895; her exact birthdate is unknown. Tragically, her father passed away which resulted in a series of bad debts that left her family crippled in financial issues. At some point, she met Caledon Hockley and prior to the maiden voyage, she became engaged to him. The goal of her mother was to have Rose marry him, and stay in their wealthy lifestyle. She is 17 years old during her first class passage aboard the RMS Titanic. Rose boards with her fiancé Caledon Hockley and her mother Ruth DeWitt Bukater. Although Rose does not love him, she is being forced to marry him by her mother. Since her father's death, according to Ruth, she was left with nothing. Rose was to marry into money.",
  //     token: ""));

  // list.add(Character(
  //   img: ,
  //   title: ,
  //   link: ,
  //   desc: )
  // );

  list.shuffle();
  return list;
}
