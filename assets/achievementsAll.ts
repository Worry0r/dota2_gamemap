import type { UserAchievements } from '~/types/TUserAchievements';

export const achievementsAll: UserAchievements[] = [
  {
    id: '1',
    name: 'One man army',
    detail: 'Defeat all enemies when you are the only left',
    imgSrc: '/achievements/achOneman.png',
  },
  {
    id: '2',
    name: 'Blood magic',
    detail: 'First win in the game',
    imgSrc: '/achievements/achBlood.png',
  },
  {
    id: '3',
    name: 'Lord Robin Hood',
    detail: 'Play as ranged attack heroe',
    imgSrc: '/achievements/achArrows.png',
  },
  {
    id: '4',
    name: 'Cuan maniac',
    detail: 'Withdraw your genius gem for more than 5.000 GG token',
    imgSrc: '/achievements/achTreasure.png',
  },
];
