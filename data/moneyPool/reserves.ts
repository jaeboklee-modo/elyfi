import { BigNumber } from 'ethers';
import InterestModelParams from '../../test/types/InterestRateModelParams';
import { SECONDSPERDAY, WAD } from '../../test/utils/constants';
import { toRate } from '../../test/utils/wadRayMath';

export const daiReserveData = {
  lToken: {
    name: 'Elyfi_DaiStablecoin_LToken',
    symbol: 'ELFI_DAI_LToken',
  },
  dToken: {
    name: 'Elyfi_DaiStablecoin_DToken',
    symbol: 'ELFI_DAI_DToken',
  },
  interestRateModel: <InterestModelParams>{
    optimalUtilizationRate: toRate(0.75),
    borrowRateBase: toRate(0.05),
    borrowRateOptimal: toRate(0.06),
    borrowRateMax: toRate(1),
  },
  tokenizer: {
    name: 'Elyfi_DaiStablecoin_Tokenzier',
    symbol: 'ELFI_DAI_Tokenizer',
  },
  incentiveAmountPerSecond: BigNumber.from(WAD).mul(3000000).div(180).div(SECONDSPERDAY),
  moneyPoolFactor: BigNumber.from(0),
};
