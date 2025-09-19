import '../model/quiz_question.dart';

List<QuizQuestion> getSampleQuizQuestions() {
  final List<Map<String, dynamic>> sampleQuizQuestions = [
    {
      'questionText': 'What does ISRO stand for?',
      'options': [
        'Indian Space Research Organization',
        'International Space Research Organization',
        'Indian Space Research Office',
        'Indian Scientific Research Organization',
      ],
      'correctAnswerIndex': 0,
      'subject': 'General',
      'difficulty': 'easy',
      'explanation': 'ISRO stands for Indian Space Research Organization, the space agency of the Government of India.',
    },
    {
      'questionText': 'When was ISRO founded?',
      'options': [
        '15 August 1947',
        '26 January 1950',
        '15 August 1969',
        '26 January 1962',
      ],
      'correctAnswerIndex': 2,
      'subject': 'History',
      'difficulty': 'medium',
      'explanation': 'ISRO was founded on August 15, 1969, succeeding the Indian National Committee for Space Research (INCOSPAR).',
    },
    {
      'questionText': 'Which was India\'s first satellite?',
      'options': [
        'Aryabhata',
        'Bhaskara',
        'Rohini',
        'INSAT-1A',
      ],
      'correctAnswerIndex': 0,
      'subject': 'Satellites',
      'difficulty': 'easy',
      'explanation': 'Aryabhata was India\'s first satellite, launched on April 19, 1975, from Kapustin Yar, Russia (then USSR).',
    },
    {
      'questionText': 'Which launch vehicle is known as the "workhorse" of ISRO?',
      'options': [
        'PSLV',
        'GSLV',
        'GSLV Mk III',
        'ASLV',
      ],
      'correctAnswerIndex': 0,
      'subject': 'Launch Vehicles',
      'difficulty': 'medium',
      'explanation': 'Polar Satellite Launch Vehicle (PSLV) is known as the workhorse of ISRO due to its reliability and numerous successful launches.',
    },
    {
      'questionText': 'Which was India\'s first mission to Mars?',
      'options': [
        'Mangalyaan',
        'Chandrayaan-1',
        'Mars Orbiter Mission',
        'Both 1 and 3',
      ],
      'correctAnswerIndex': 3,
      'subject': 'Missions',
      'difficulty': 'medium',
      'explanation': 'Mangalyaan, also known as the Mars Orbiter Mission (MOM), was India\'s first interplanetary mission.',
    },
    {
      'questionText': 'Where is the Satish Dhawan Space Centre (SDSC) located?',
      'options': [
        'Thiruvananthapuram, Kerala',
        'Sriharikota, Andhra Pradesh',
        'Bangalore, Karnataka',
        'Ahmedabad, Gujarat',
      ],
      'correctAnswerIndex': 1,
      'subject': 'Centers',
      'difficulty': 'easy',
      'explanation': 'The Satish Dhawan Space Centre (SDSC) is located in Sriharikota, Andhra Pradesh, and serves as the primary launch center of ISRO.',
    },
    {
      'questionText': 'Which was the first Indian lunar exploration mission?',
      'options': [
        'Chandrayaan-1',
        'Chandrayaan-2',
        'Mangalyaan',
        'Gaganyaan',
      ],
      'correctAnswerIndex': 0,
      'subject': 'Missions',
      'difficulty': 'easy',
      'explanation': 'Chandrayaan-1 was India\'s first lunar probe, launched by ISRO in October 2008.',
    },
    {
      'questionText': 'What is the name of India\'s first human spaceflight program?',
      'options': [
        'Gaganyaan',
        'Vyom Mitra',
        'Gaganyan',
        'Gaganyatra',
      ],
      'correctAnswerIndex': 0,
      'subject': 'Missions',
      'difficulty': 'medium',
      'explanation': 'Gaganyaan is India\'s first human spaceflight program, aiming to send Indian astronauts to space by 2024.',
    },
    {
      'questionText': 'Which rocket is used for the Gaganyaan mission?',
      'options': [
        'PSLV',
        'GSLV Mk II',
        'GSLV Mk III',
        'SSLV',
      ],
      'correctAnswerIndex': 2,
      'subject': 'Launch Vehicles',
      'difficulty': 'hard',
      'explanation': 'The GSLV Mk III, also known as LVM3, is the launch vehicle designated for the Gaganyaan mission.',
    },
    {
      'questionText': 'What is the name of India\'s first solar mission?',
      'options': [
        'Aditya-L1',
        'Surya-1',
        'Surya Mitra',
        'Aditya-1',
      ],
      'correctAnswerIndex': 0,
      'subject': 'Missions',
      'difficulty': 'medium',
      'explanation': 'Aditya-L1 is India\'s first dedicated scientific mission to study the Sun, scheduled for launch to the L1 Lagrange point.',
    },
  ];

  return sampleQuizQuestions
      .asMap()
      .entries
      .map((entry) => QuizQuestion(
            id: 'q${entry.key + 1}',
            questionText: entry.value['questionText'] as String,
            options: List<String>.from(entry.value['options'] as List<dynamic>),
            correctAnswerIndex: entry.value['correctAnswerIndex'] as int,
            subject: entry.value['subject'] as String,
            difficulty: entry.value['difficulty'] as String,
            explanation: entry.value['explanation'] as String?,
          ))
      .toList();
}
