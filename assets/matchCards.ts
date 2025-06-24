import type { DashboardCard } from '@/types/TDashboardCard';

const matchCards: DashboardCard[] = [
  {
    imgSrc: '/games/csgo/csgoIntro.png',
    header: 'Counter-Strike: GO',
    description: 'See the game statistic that you had been played',
    buttonText: 'Connect server',
    redirectTo: '/matches/csgo',
  },
  {
    imgSrc: '/games/lol/lolIntro.png',
    header: 'League of Legends',
    description: 'See the game statistic that you had been played',
    buttonText: 'Connect server',
    redirectTo: '/matches/lol',
  },
  {
    imgSrc: '/games/dota/dotaIntro.png',
    header: 'Dota 2',
    description: 'See the game statistic that you had been played',
    buttonText: 'Connect server',
    redirectTo: '/matches/dota',
  },
];

export default matchCards;
