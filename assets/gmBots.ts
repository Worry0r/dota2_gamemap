import type { GMBot } from '~/types/TGMBot';

export const gmBotsAll: GMBot[] = [
  {
    id: '1547',
    name: 'Karl',
    imgSrc: '/bots/botKarl.jpeg',
    winRate: 73,
    price: 100,
    games: [
      {
        name: 'Dota2',
        playedHours: 120,
        focus: true,
      },
      {
        name: 'CS:GO',
        playedHours: 80,
        focus: false,
      },
    ],
  },
  {
    id: '1758',
    name: 'James BOT',
    imgSrc: '/bots/botJames.jpeg',
    winRate: 71,
    price: 200,
    games: [
      {
        name: 'CS:GO',
        playedHours: 150,
        focus: true,
      },
      {
        name: 'LOL',
        playedHours: 50,
        focus: false,
      },
    ],
  },
  {
    id: '1987',
    name: 'AI boss v2',
    imgSrc: 'bots/botBoss.jpeg',
    winRate: 80,
    price: 300,
    games: [
      {
        name: 'Forza',
        playedHours: 200,
        focus: false,
      },
      {
        name: 'Game H',
        playedHours: 100,
        focus: false,
      },
      {
        name: 'LOL',
        playedHours: 150,
        focus: true,
      },
      {
        name: 'CS:GO',
        playedHours: 1110,
        focus: true,
      },
    ],
  },
  {
    id: '1999',
    name: 'Lana',
    imgSrc: 'bots/botLana.jpg',
    winRate: 90,
    price: 400,
    games: [
      {
        name: 'Dota2',
        playedHours: 300,
        focus: true,
        heroesFocus: [
          'Abaddon',
          'Axe',
          'Bloodseeker',
          'Lina',
          'Drow Ranger',
          'Pudge',
          'Invoker',
          'Winter Wyvern',
          'Crystal Maiden',
          'Shadow Fiend',
          'Windranger',
          'Zeus',
        ],
      },
      {
        name: 'LOL',
        playedHours: 100,
        focus: false,
      },
    ],
  },
  {
    id: '2051',
    name: 'Huricane',
    imgSrc: '/bots/botHurricane.jpeg',
    winRate: 75,
    price: 150,
    games: [
      {
        name: 'Dota2',
        playedHours: 250,
        focus: true,
        heroesFocus: [
          'Invoker',
          'Pudge',
          'Luna',
          'Lina',
          'Drow Ranger',
        ],
      },
      {
        name: 'CS:GO',
        playedHours: 100,
        focus: false,
      },
    ],
  },
  {
    id: '2052',
    name: 'Sunny',
    imgSrc: 'bots/botSunny.jpg',
    winRate: 87,
    price: 250,
    games: [
      {
        name: 'Dota2',
        playedHours: 200,
        focus: true,
        heroesFocus: [
          'Abaddon',
          'Bloodseeker',
          'Crystal Maiden',
          'Shadow Fiend',
          'Zeus',
        ],
      },
      {
        name: 'LOL',
        playedHours: 150,
        focus: false,
      },
    ],
  },

  {
    id: '2153',
    name: 'Storm',
    imgSrc: 'bots/botStorm.jpeg',
    winRate: 93,
    price: 180,
    games: [
      {
        name: 'Dota2',
        playedHours: 400,
        focus: true,
        heroesFocus: [
          'Storm Spirit',
          'Ember Spirit',
          'Earth Spirit',
          'Timbersaw',
          'Tidehunter',
          'Kunkka',
        ],
      },
      {
        name: 'LOL',
        playedHours: 100,
        focus: false,
      },
      {
        name: 'Forza',
        playedHours: 50,
        focus: false,
      },
    ],
  },
  {
    id: '2256',
    name: 'LunaX',
    imgSrc: 'bots/botLuna.jpeg',
    winRate: 85,
    price: 220,
    games: [
      {
        name: 'Dota2',
        playedHours: 320,
        focus: true,
        heroesFocus: [
          'Luna',
          'Mirana',
          'Vengeful Spirit',
          'Medusa',
          'Batrider',
          'Dark Seer',
        ],
      },
      {
        name: 'Game H',
        playedHours: 60,
        focus: false,
      },
      {
        name: 'Forza',
        playedHours: 85,
        focus: false,
      },
    ],
  },
  {
    id: '2359',
    name: 'Blaze',
    imgSrc: 'bots/botBlaze.jpeg',
    winRate: 77,
    price: 190,
    games: [
      {
        name: 'Dota2',
        playedHours: 220,
        focus: true,
        heroesFocus: [
          'Ember Spirit',
          'Phoenix',
          'Lina',
          'Slardar',
          'Slark',
          'Sven',
        ],
      },
      {
        name: 'LOL',
        playedHours: 180,
        focus: false,
      },
    ],
  },
  {
    id: '2452',
    name: 'Frost',
    imgSrc: 'bots/botFrost.jpeg',
    winRate: 80,
    price: 210,
    games: [
      {
        name: 'Dota2',
        playedHours: 270,
        focus: true,
        heroesFocus: [
          'Crystal Maiden',
          'Winter Wyvern',
          'Lich',
        ],
      },
      {
        name: 'CS:GO',
        playedHours: 120,
        focus: false,
      },
    ],
  },
  {
    id: '2555',
    name: 'Shadow',
    imgSrc: 'bots/botShadow.jpeg',
    winRate: 91,
    price: 240,
    games: [
      {
        name: 'Dota2',
        playedHours: 310,
        focus: true,
        heroesFocus: [
          'Shadow Fiend',
          'Shadow Shaman',
          'Shadow Demon',
        ],
      },

      {
        name: 'LOL',
        playedHours: 150,
        focus: false,
      },
      {
        name: 'CS:GO',
        playedHours: 80,
        focus: false,
      },
      {
        name: 'Forza',
        playedHours: 40,
        focus: false,
      },
      {
        name: 'Game H',
        playedHours: 25,
        focus: false,
      },
    ],
  },
  {
    id: '2658',
    name: 'Tide',
    imgSrc: 'bots/botTide.jpeg',
    winRate: 83,
    price: 170,
    games: [
      {
        name: 'Dota2',
        playedHours: 500,
        focus: true,

        heroesFocus: [
          'Tidehunter',
          'Kunkka',
          'Slardar',
          'Legion Commander',
          'Sven',
          'Lifestealer',
          'Wraith King',
          'Chaos Knight',
          'Dragon Knight',
          'Centaur Warrunner',
        ],
      },
    ],
  },
  {
    id: '2751',
    name: 'Wind',
    imgSrc: 'bots/botWind.jpeg',
    winRate: 87,
    price: 260,
    games: [
      {
        name: 'Dota2',
        playedHours: 350,
        focus: true,
        heroesFocus: [
          'Windranger',
          'Invoker',
          'Enchantress',
          'Dark Seer',
          'Dark Willow',
          "Nature's Prophet",
        ],
      },
      {
        name: 'LOL',
        playedHours: 110,
        focus: false,
      },
      {
        name: 'CS:GO',
        playedHours: 90,
        focus: false,
      },
    ],
  },
  {
    id: '2854',
    name: 'Earth',
    imgSrc: 'bots/botEarth.jpeg',
    winRate: 78,
    price: 200,
    games: [
      {
        name: 'Dota2',
        playedHours: 450,
        focus: true,
        heroesFocus: [
          'Pudge',
          'Spirit Breaker',
          'Earth Spirit',
          'Earthshaker',
          'Sand King',
          'Tiny',
          'Treant Protector',
        ],
      },
    ],
  },
  {
    id: '2957',
    name: 'Phoenix',
    imgSrc: 'bots/botPhoenix.jpeg',
    winRate: 85,
    price: 230,
    games: [
      {
        name: 'Dota2',
        playedHours: 280,
        focus: true,
        heroesFocus: [
          'Phoenix',
          'Ember Spirit',
          'Invoker',
        ],
      },
      {
        name: 'LOL',
        playedHours: 130,
        focus: false,
      },
    ],
  },
  {
    id: '3050',
    name: 'Mystic',
    imgSrc: 'bots/botMystic.jpeg',
    winRate: 82,
    price: 220,
    games: [
      {
        name: 'Dota2',
        playedHours: 600,
        focus: true,
        heroesFocus: [
          'Oracle',
          'Shadow Shaman',
          'Enchantress',
          'Lycan',
          'Lone Druid',
          'Naga Siren',
          'Visage',
          'Broodmother',
          'Meepo',
          'Arc Warden',
          'Omniknight',
        ],
      },
    ],
  },
];
