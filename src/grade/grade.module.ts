import { Module } from '@nestjs/common';
import { GradeService } from './grade.service';
import { GradeController } from './grade.controller';
import { DrizzleModule } from 'src/drizzle/drizzle.module';

@Module({
  controllers: [GradeController],
  providers: [GradeService],
  imports: [DrizzleModule],
})
export class GradeModule {}
