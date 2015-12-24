package com.aVictorio.youngScholars.vos
{
	[Bindable]
	public class MathQuestion
	{
		public static const ADDITION:String = "ADDITION";
		public static const DEDUCTION:String = "DEDUCTION";
		public static const MULTIPLICATION:String = "MULTIPLICATION";
		public static const DIVISION:String = "DIVISION";
		
		public static const ADDITION_UNDER10:String = "ADDITION_UNDER10";
		public static const ADDITION_BY2:String = "ADDITION_BY2";
		public static const ADDITION_UNDER20:String = "ADDITION_UNDER20";
		public static const ADDITION_BY5:String = "ADDITION_BY5";
		public static const ADDITION_BY10:String = "ADDITION_BY10";
		public static const ADDITION_BY3:String = "ADDITION_BY3";
		public static const ADDITION_UNDER100:String = "ADDITION_UNDER100";
		
		public static const DEDUCTION_UNDER10:String = "DEDUCTION_UNDER10";
		public static const DEDUCTION_BY1:String = "DEDUCTION_BY1";
		public static const DEDUCTION_BY2:String = "DEDUCTION_BY2";
		public static const DEDUCTION_UNDER20:String = "DEDUCTION_UNDER20";
		public static const DEDUCTION_BY5:String = "DEDUCTION_BY5";
		public static const DEDUCTION_BY10:String = "DEDUCTION_BY10";
		public static const DEDUCTION_BY3:String = "DEDUCTION_BY3";
		public static const DEDUCTION_UNDER100:String = "DEDUCTION_UNDER100";
		
		public static const MULTIPLICATION_UNDER10:String = "MULTIPLICATION_UNDER10";
		public static const MULTIPLICATION_BY1:String = "MULTIPLICATION_BY1";
		public static const MULTIPLICATION_BY2:String = "MULTIPLICATION_BY2";
		public static const MULTIPLICATION_BY3:String = "MULTIPLICATION_BY3";
		public static const MULTIPLICATION_BY4:String = "MULTIPLICATION_BY4";
		public static const MULTIPLICATION_BY5:String = "MULTIPLICATION_BY5";
		public static const MULTIPLICATION_BY6:String = "MULTIPLICATION_BY6";
		public static const MULTIPLICATION_BY7:String = "MULTIPLICATION_BY7";
		public static const MULTIPLICATION_BY8:String = "MULTIPLICATION_BY8";
		public static const MULTIPLICATION_BY9:String = "MULTIPLICATION_BY9";
		public static const MULTIPLICATION_BY10:String = "MULTIPLICATION_BY10";
		public static const MULTIPLICATION_UNDER20:String = "MULTIPLICATION_UNDER20";
		public static const MULTIPLICATION_UNDER100:String = "MULTIPLICATION_UNDER100";
		
		public static const DIVISION_UNDER10:String = "DIVISION_UNDER10";
		public static const DIVISION_BY2:String = "DIVISION_BY2";
		public static const DIVISION_UNDER20:String = "DIVISION_UNDER20";
		public static const DIVISION_BY5:String = "DIVISION_BY5";
		public static const DIVISION_BY10:String = "DIVISION_BY10";
		public static const DIVISION_BY3:String = "DIVISION_BY3";
		public static const DIVISION_UNDER100:String = "DIVISION_UNDER100";

		
		protected var _quizType:String=null;

		public var operationType:String;
		public var operator1:int=0;
		public var operator2:int=0;
		public var operation:String="+";
		public var answers:Array;
		public var correctAnswer:int;
		public var index:int;
		public var NumberOfQuestions:int;
		
		public function MathQuestion()
		{
			
		}
		
		public function get quizType():String
		{
			return _quizType;
		}
		
		public function set quizType(value:String):void
		{
			_quizType = value;
			
			operationType = getType(quizType);
			operation = getOperationString(operationType);
		}

		
		public function getType(quizType:String):String
		{
			if (quizType.indexOf(ADDITION)>=0)
				return ADDITION;
			else if (quizType.indexOf(DEDUCTION)>=0)
				return DEDUCTION;
			else if (quizType.indexOf(MULTIPLICATION)>=0)
				return MULTIPLICATION;
			else if (quizType.indexOf(DIVISION)>=0)
				return DIVISION;
			
			return ADDITION; //by default
		}
		
		public function getOperationString(type:String):String
		{
			switch (type)
			{
				case DEDUCTION: 		return "-";
				case MULTIPLICATION: 	return "x";
				case DIVISION:			return "÷";
				case ADDITION:			
				default:
					return "+";
			}			
		}

		
		public function generateQuestion(lastAnswer:int):void
		{
			var sequetialByType:Boolean = false;
			var range:int;
			var byCount:int;
			
			switch (quizType)
			{
				case ADDITION_UNDER10:
				case DEDUCTION_UNDER10:
				case MULTIPLICATION_UNDER10:
				case DIVISION_UNDER10:
					sequetialByType = false;
					range = 10;

					NumberOfQuestions = 10;
					break;
				case ADDITION_UNDER20:
				case DEDUCTION_UNDER20:
				case MULTIPLICATION_UNDER20:
				case DIVISION_UNDER20:
					sequetialByType = false;
					range = 20;
					
					NumberOfQuestions = 10;
					break;
				case ADDITION_UNDER100:
				case DEDUCTION_UNDER100:
				case MULTIPLICATION_UNDER100:
				case DIVISION_UNDER100:
					sequetialByType = false;
					range = 100;
					
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY1:
				case DEDUCTION_BY1:
					range =20;
					sequetialByType = true;
					byCount = 1;
					NumberOfQuestions = 10;
					break;
				case ADDITION_BY2:
				case DEDUCTION_BY2:
					sequetialByType = true;
					byCount = 2;
					range = 20;
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY2:
					sequetialByType = true;
					byCount = 2;
					range = 20;
					NumberOfQuestions = 10;
					break;
				case DIVISION_BY2:
					sequetialByType = true;
					byCount = 2;
					range = 32;
					NumberOfQuestions = 5;
					break;
				case ADDITION_BY3:
				case DEDUCTION_BY3:
					sequetialByType = true;
					byCount = 3;
					range = 21;
					NumberOfQuestions = 8;
					break;
				case MULTIPLICATION_BY3:
				case DIVISION_BY3:
					sequetialByType = true;
					byCount = 3;
					range = 30;
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY4:
					sequetialByType = true;
					byCount = 4;
					range = 40;
					NumberOfQuestions = 10;
					break;
				case ADDITION_BY5:
				case DEDUCTION_BY5:
				case MULTIPLICATION_BY5:
				case DIVISION_BY5:
					sequetialByType = true;
					byCount = 5;
					range = 50;
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY6:
					sequetialByType = true;
					byCount = 6;
					range = 60;
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY7:
					sequetialByType = true;
					byCount = 7;
					range = 70;
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY8:
					sequetialByType = true;
					byCount = 8;
					range = 80;
					NumberOfQuestions = 10;
					break;
				case MULTIPLICATION_BY9:
					sequetialByType = true;
					byCount = 9;
					range = 90;
					NumberOfQuestions = 10;
					break;
				case ADDITION_BY10:
				case DEDUCTION_BY10:
				case MULTIPLICATION_BY10:
				case DIVISION_BY10:
					sequetialByType = true;
					byCount = 10;
					range = 100;
					NumberOfQuestions = 10;
					break;
			}
			
			if (sequetialByType)
			{
				operator1 = lastAnswer;
				operator2 = byCount;
				
				switch (operationType)
				{
					case ADDITION:
						if (operator1 == -1) operator1 = 0;
						correctAnswer = operator1 + operator2;
						break;
					
					case DEDUCTION:
						if (operator1 == -1) operator1 = range;
						correctAnswer = operator1 - operator2;
						break;
					case MULTIPLICATION:
						if (operator1 == -1) 
							operator1 = 1;
						else 
							operator1=(lastAnswer/byCount)+1;
						
						correctAnswer = operator1 * operator2;
						break;
					case DIVISION:
						if (operator1 == -1)
						{
							operator1 = range;
						}
						correctAnswer = operator1/operator2;
				}
			}//end if
			else
			{
				operator1 = Math.random() * range;
				
				switch (operationType)
				{
					case ADDITION:
						operator2 = Math.random() * range;
						correctAnswer = operator1 + operator2;
						break;

					case DEDUCTION:
						operator2 = Math.random() * operator1;
						correctAnswer = operator1 - operator2;
						break;
					case MULTIPLICATION:
						operator2 = Math.random() * 10;
						correctAnswer = operator1 * operator2;
						break;
					case DIVISION:
						operator2 = (Math.random() * 10+1);	//add 1 to avoid it being 0					
						correctAnswer = int(Math.random() * range);
						operator1 = correctAnswer * operator2;
				}
			}//end else
			
			var index:int = (Math.random()*10)%4;
			answers = new Array();
			var i:int=0;
			while (i<4)
			{
				if (i==index)
				{
					if (!exists(correctAnswer, answers))
					{
						answers.push(correctAnswer);
						i++;
					}
					else
					{//correct answer is alreay in array, so just disable index checking
						index=i-1;  //just make equal not possible for later loops
					}
				}
				else 
				{
					var answer:int = int(Math.random() * 10 + correctAnswer);
					if (!exists(answer, answers))
					{
						answers.push(answer);
						i++;
					}
					//else try again to find a distinct number
				}
			}
		}
		
		private function exists(answer:int, answers:Array):Boolean
		{
			for each (var a:int in answers)
			{
				if (a == answer)
					return true;
			}
			return false;
		}
	}
}