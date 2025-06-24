import type { User } from '~/types/TUser';

export const usersAll: User[] = [
  {
    id: '1',
    username: 'John Doe',
    imgSrc: '/users/userJohn.jpeg',
    walletAddress:
      '0xF267e13d7C0977d3a60aCF32193A8A68568a4163',
    achievements: ['1', '2'],
    games: ['Dota2', 'CS:GO', 'LOL'],
    bots: ['1758'],
    friends: ['2', '3', '4', '5'],
  },
  {
    id: '2',
    username: 'Mike Smith',
    imgSrc: '/users/userMike.jpeg',
    walletAddress:
      '0x0xb794f5ea0ba39494ce839613fffba74279579268',
    achievements: ['1', '2', '3', '4'],
    games: ['Dota2'],
    bots: ['1999', '1987', '2051', '2052'],
    friends: ['1', '3', '4', '5'],
  },
  {
    id: '3',
    username: 'Karl Maxman',
    imgSrc: '/users/userKarl.jpeg',
    walletAddress:
      '0xEcec661CD287C068235ABeb4e622ECB5733CEb13',
    achievements: [],
    games: ['CS:GO'],
    bots: ['1758', '1987'],
    friends: ['1', '2', '4', '5'],
  },
  {
    id: '4',
    username: 'Joana Sanders',
    imgSrc: '/users/userJoana.jpeg',
    walletAddress:
      '0xABec661CD287C068235ABeb4e622ECB573xOp7',
    achievements: ['2', '3'],
    games: ['LOL'],
    bots: ['1999'],
    friends: ['1', '2', '3', '5'],
  },
  {
    id: '5',
    username: 'Lana',
    imgSrc: '/users/userLana.jpeg',
    walletAddress:
      '0xlo2k661CD287C068235ABeb4e622ECB5733Cke8n',
    achievements: ['2', '4'],
    games: ['LOL', 'CS:GO'],
    bots: ['1999', '1987'],
    friends: ['1', '2', '3', '4'],
  },
  {
    id: '6',
    username: 'Alex Chen',
    imgSrc:
      'https://registration.brooo.tv/storage/v1/object/public/hub/avatars/general/40.png',
    walletAddress:
      '0x7Fc661CD287C068235ABeb4e622ECB5733CEb99',
    achievements: ['1', '3', '4'],
    games: ['Dota2', 'LOL'],
    bots: ['2051', '2256'],
    friends: ['7', '8', '9', '10'],
  },
  {
    id: '7',
    username: 'Sarah Wilson',
    imgSrc:
      'https://registration.brooo.tv/storage/v1/object/public/hub/avatars/general/10.png',
    walletAddress:
      '0x9Bec661CD287C068235ABeb4e622ECB5733CEb45',
    achievements: ['2', '3'],
    games: ['CS:GO', 'LOL'],
    bots: ['1758', '2052'],
    friends: ['6', '8', '9', '10'],
  },
  {
    id: '8',
    username: 'Marcus Johnson',
    imgSrc:
      'https://registration.brooo.tv/storage/v1/object/public/hub/avatars/general/20.png',
    walletAddress:
      '0x5Dec661CD287C068235ABeb4e622ECB5733CEb77',
    achievements: ['1', '2', '3', '4'],
    games: ['Dota2', 'CS:GO'],
    bots: ['1999', '2051', '2256'],
    friends: ['6', '7', '9', '10'],
  },
  {
    id: '9',
    username: 'Emma Davis',
    imgSrc:
      'https://registration.brooo.tv/storage/v1/object/public/hub/avatars/general/11.png',
    walletAddress:
      '0x3Aec661CD287C068235ABeb4e622ECB5733CEb22',
    achievements: ['1', '4'],
    games: ['LOL'],
    bots: ['1758', '1987', '1999'],
    friends: ['6', '7', '8', '10'],
  },
  {
    id: '10',
    username: 'Ryan Taylor',
    imgSrc:
      'https://registration.brooo.tv/storage/v1/object/public/hub/avatars/general/12.png',
    walletAddress:
      '0x8Cec661CD287C068235ABeb4e622ECB5733CEb11',
    achievements: ['2', '3', '4'],
    games: ['Dota2', 'CS:GO', 'LOL'],
    bots: ['2051', '2052', '2256'],
    friends: ['6', '7', '8', '9'],
  },
];
