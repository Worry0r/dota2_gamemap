import type { DashboardCard } from '@/types/TDashboardCard';

const dashboardCards: DashboardCard[] = [
  {
    imgSrc: '/robot.png',
    header: 'Game mind list',
    description: 'All of game mind lists are presented here',
    buttonText: 'Arrange my game mind squad',
    redirectTo: '/gameminds',
  },
  {
    imgSrc: '/robots.png',
    header: 'Game Statistics',
    description: 'See the game statistics that you had been played',
    buttonText: 'See the game statistics',
    redirectTo: '/gameminds',
  },
  {
    imgSrc: '/games/forza/car.png',
    header: 'Match',
    description:
      'Create a match, train your model, train your BOT by using this feature',
    buttonText: 'Go to match',
    redirectTo: '/matches',
  },
];

export default dashboardCards;
