import type {
  MarketplaceFilters,
  MatchFilters,
} from '~/types/TFilters';

const matchFilterOptions: Omit<
  MatchFilters,
  'betFrom'
> = {
  playedBy: ['Player', 'BOT'],
  playerRank: [
    'Herald',
    'Guardian',
    'Crusader',
    'Archon',
    'Legend',
    'Ancient',
    'Divine',
  ],
  winCondition: ['Team winning', 'Total kill'],
  gameType: [
    '1v1',
    '5v5',
    '5v5 Random',
    '5v5 Captain',
    '5v5 Turbo',
    '5v5 Single draft',
  ],
};

const categoryLabels: Record<
  keyof MatchFilters,
  string
> = {
  betFrom: 'Bet Numbers',
  betTo: 'Bet To',
  playedBy: 'Played By',
  playerRank: 'Player Rank',
  winCondition: 'Win Condition',
  gameType: 'Game Type',
};

const marketplaceFilterOptions: MarketplaceFilters =
  {
    price: 500,
    winrate: 100,
    games: [
      'Dota2',
      'CS:GO',
      'LOL',
      'Forza',
      'Game H',
    ],
    focusGame: 'Dota2',
    nameOrId: '',
  };

const marketplaceCategoryLabels = {
  price: 'Max price $',
  winrate: 'Winrate %',
  games: 'Games',
  focusGame: 'Focus Game',
};

export {
  matchFilterOptions,
  categoryLabels,
  marketplaceCategoryLabels,
};
