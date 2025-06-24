import type { Rank } from '@/types/TRank';

export const dotaRanksSimple: Rank[] = [
  {
    name: 'Herald',
    rankMin: 0,
    rankMax: 616,
  },
  {
    name: 'Guardian',
    rankMin: 617,
    rankMax: 1539,
  },
  {
    name: 'Crusader',
    rankMin: 1540,
    rankMax: 2309,
  },
  {
    name: 'Archon',
    rankMin: 2310,
    rankMax: 3079,
  },
  {
    name: 'Legend',
    rankMin: 3080,
    rankMax: 3849,
  },
  {
    name: 'Ancient',
    rankMin: 3850,
    rankMax: 4619,
  },
  {
    name: 'Divine',
    rankMin: 4620,
    rankMax: 10000,
  },
];

export const dotaRanks: Rank[] = [
  {
    name: 'Herald',
    stars: [0, 154, 308, 462, 616],
  },
  {
    name: 'Guardian',
    stars: [770, 924, 1078, 1232, 1386],
  },
  {
    name: 'Crusader',
    stars: [1540, 1694, 1848, 2002, 2156],
  },
  {
    name: 'Archon',
    stars: [2310, 2464, 2618, 2772, 2926],
  },
  {
    name: 'Legend',
    stars: [3080, 3234, 3388, 3542, 3696],
  },
  {
    name: 'Ancient',
    stars: [3850, 4004, 4158, 4312, 4466],
  },
  {
    name: 'Divine',
    stars: [4620, 4820, 5020, 5220, 5420],
  },
];
