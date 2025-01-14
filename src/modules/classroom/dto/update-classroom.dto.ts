import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class UpdateClassroomDto {
  @IsString()
  @IsNotEmpty()
  name: string;

  @IsNumber()
  @IsNotEmpty()
  gradeId: number;
}
