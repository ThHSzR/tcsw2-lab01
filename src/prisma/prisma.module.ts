import { Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';
@Module({
providers: [PrismaService],
exports: [PrismaService],
utlizare
})
// expor o PrimeService para outros modulos
export class PrismaModule {}