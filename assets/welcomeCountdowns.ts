import type { WelcomeCountdown } from '~/types/TWelcomeCountdown';

export const welcomeCountdowns: WelcomeCountdown[] =
  [
    {
      price: '$175',
      timeLeft: '05:18',
      game: 'DOTA2',
      players: 5,
      bots: 5,
      buttonText: 'CTA',
    },
    {
      price: '$50',
      timeLeft: '00:15',
      game: 'LOL',
      players: 5,
      bots: 5,
      buttonText: 'CTA',
    },
    {
      price: '$100',
      timeLeft: '07:03',
      game: 'CSGO',
      players: 5,
      bots: 5,
      buttonText: 'CTA',
    },
    {
      price: '$75',
      timeLeft: '01:12',
      game: 'DOTA2',
      players: 5,
      bots: 5,
      buttonText: 'CTA',
    },
  ];

export const welcomeTableColumns = [
  'Price',
  'Time Left',
  'Game',
  'Format',
  'Play',
];
